import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/episode.dart';

class VideoPlayerPage extends StatefulWidget {
  final Episode episode;

  const VideoPlayerPage({super.key, required this.episode});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  String? _errorMessage;

  Future<void> _initializePlayer() async {
    try {
      print('🎬 Initializing video player...');
      print('📹 Video URL: ${widget.episode.videoUrl}');

      // Smart detection: Network URL vs Local File vs Assets
      final videoUrl = widget.episode.videoUrl;
      
      if (videoUrl.startsWith('http://') || videoUrl.startsWith('https://')) {
        // Network video (online streaming)
        print('🌐 Loading from network...');
        _videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(videoUrl),
        );
      } else if (videoUrl.startsWith('assets/')) {
        // Asset video (bundled with app)
        print('📦 Loading from assets...');
        _videoPlayerController = VideoPlayerController.asset(videoUrl);
      } else {
        // Local file video (device storage)
        print('📱 Loading from local file...');
        _videoPlayerController = VideoPlayerController.file(
          File(videoUrl),
        );
      }

      // Listen for errors
      _videoPlayerController.addListener(() {
        if (_videoPlayerController.value.hasError) {
          print(
            '❌ VideoPlayerController error: ${_videoPlayerController.value.errorDescription}',
          );
          setState(() {
            _hasError = true;
            _errorMessage =
                _videoPlayerController.value.errorDescription ??
                'Unknown video player error';
          });
        }
      });

      print('⏳ Waiting for video to initialize...');
      await _videoPlayerController.initialize();
      print('✅ Video initialized successfully!');
      print(
        '📊 Video info: ${_videoPlayerController.value.size.width}x${_videoPlayerController.value.size.height}',
      );
      print('⏱️ Duration: ${_videoPlayerController.value.duration}');

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        autoInitialize: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primaryOrange,
          handleColor: AppColors.primaryOrange,
          backgroundColor: AppColors.textTertiary,
          bufferedColor: AppColors.textSecondary,
        ),
        placeholder: Container(
          color: AppColors.backgroundDark,
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.primaryOrange),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          print('❌ Chewie error: $errorMessage');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: AppColors.error,
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading video',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    errorMessage,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      );

      // Manually start playback
      print('▶️ Starting video playback...');
      await _videoPlayerController.play();
      print('🎥 Video is now playing!');

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('❌ ERROR initializing video player: $e');
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Text(
          'Episode ${widget.episode.episodeNumber}: ${widget.episode.title}',
        ),
      ),
      body: Column(
        children: [
          AspectRatio(aspectRatio: 16 / 9, child: _buildVideoPlayer()),
          Expanded(child: _buildEpisodeInfo()),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_hasError) {
      return Container(
        color: AppColors.backgroundDark,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 64),
              const SizedBox(height: 16),
              Text(
                'Failed to load video',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (_errorMessage != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    _errorMessage!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.error),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              const SizedBox(height: 2.4),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _hasError = false;
                    _errorMessage = null;
                  });
                  _initializePlayer();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (!_isInitialized || _chewieController == null) {
      return Container(
        color: AppColors.backgroundDark,
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.primaryOrange),
        ),
      );
    }

    return Chewie(controller: _chewieController!);
  }

  Widget _buildEpisodeInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Episode ${widget.episode.episodeNumber}',
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppColors.primaryOrange),
          ),
          const SizedBox(height: 8),
          Text(
            widget.episode.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                widget.episode.formattedDuration,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (widget.episode.releaseDate != null) ...[
                const SizedBox(width: 16),
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${widget.episode.releaseDate!.day}/${widget.episode.releaseDate!.month}/${widget.episode.releaseDate!.year}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
          if (widget.episode.description != null) ...[
            const SizedBox(height: 16),
            const Divider(color: AppColors.divider),
            const SizedBox(height: 16),
            Text('Description', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              widget.episode.description!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
