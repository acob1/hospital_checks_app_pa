class VideoPost {
  final String id;
  final String videoUrl;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImage;
  final String description;
  int likes;
  int comments;
  int shares;
  bool isLiked;
  bool isBookmarked;
  final bool isLocal;

  VideoPost({
    required this.id,
    required this.videoUrl,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImage,
    required this.description,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.isLiked = false,
    this.isBookmarked = false,
    this.isLocal = false,
  });
}

final List<VideoPost> sampleVideoPosts = [
  VideoPost(
    id: '1',
    videoUrl:
        'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    doctorName: 'Dr. Sarah Chen',
    doctorSpecialty: 'Cardiologist',
    doctorImage: 'https://i.pravatar.cc/150?img=1',
    description: 'Heart health tips: 5 simple exercises you can do daily to keep your heart strong and healthy.',
    likes: 1243,
    comments: 89,
    shares: 45,
  ),
  VideoPost(
    id: '2',
    videoUrl:
        'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    doctorName: 'Dr. James Wilson',
    doctorSpecialty: 'Nutritionist',
    doctorImage: 'https://i.pravatar.cc/150?img=3',
    description: 'The truth about sugar: How it affects your body and what you can eat instead.',
    likes: 3421,
    comments: 234,
    shares: 178,
  ),
  VideoPost(
    id: '3',
    videoUrl:
        'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    doctorName: 'Dr. Emily Park',
    doctorSpecialty: 'Dermatologist',
    doctorImage: 'https://i.pravatar.cc/150?img=5',
    description: 'Morning skincare routine that actually works. Stop wasting money on products you don\'t need!',
    likes: 5678,
    comments: 456,
    shares: 321,
  ),
  VideoPost(
    id: '4',
    videoUrl:
        'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    doctorName: 'Dr. Michael Ross',
    doctorSpecialty: 'Orthopedic',
    doctorImage: 'https://i.pravatar.cc/150?img=8',
    description: 'Desk workers: Fix your posture in 30 days with these 3 stretches. Your back will thank you!',
    likes: 2156,
    comments: 167,
    shares: 98,
  ),
  VideoPost(
    id: '5',
    videoUrl:
        'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
    doctorName: 'Dr. Lisa Thompson',
    doctorSpecialty: 'Psychiatrist',
    doctorImage: 'https://i.pravatar.cc/150?img=9',
    description: 'Anxiety management: A breathing technique that works in under 60 seconds.',
    likes: 8932,
    comments: 623,
    shares: 512,
  ),
];
