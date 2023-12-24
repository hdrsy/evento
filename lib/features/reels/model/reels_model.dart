class RR {
  final int id;
  final String userName;
  final List<VideoDetails> videos; // List of videos with details

  RR({
    required this.id,
    required this.videos, // Updated to list of VideoDetails
    required this.userName,
  });
   Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
  };
  factory RR.fromJson(Map<String, dynamic> json) => RR(
    id: json["id"],
    userName: json["userName"],
    videos: List<VideoDetails>.from(json["videos"].map((x) => VideoDetails.fromJson(x))),
  );
}

class VideoDetails {
  final String url;
  final String description;
    bool isLiked;
  final String date; // Assuming date is a String for simplicity

  VideoDetails({
    required this.url,
    required this.description,
    this.isLiked=false,
    required this.date,
  });
  Map<String, dynamic> toJson() => {
    "url": url,
    "description": description,
    "date": date,
  };
  factory VideoDetails.fromJson(Map<String, dynamic> json) => VideoDetails(
    url: json["url"],
    description: json["description"],
    date: json["date"],
  );
}

List<RR> getFakeData() {
  return [
    RR(
      id: 0,
      userName: "User 1",
      videos: [
        VideoDetails(
          url:
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
             description: 'A story of a giant rabbit.',
          date: '2023-01-01',
        ),
        VideoDetails(
          url:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
          description: 'The first Blender Open Movie from 2006.',
          date: '2023-01-02',
        ),
        VideoDetails(
          url:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
          description: 'The first Blender Open Movie from 2006.',
          date: '2023-01-02',
        ),
      ],
    ),
    RR(
      id: 1,
      userName: "User 2",
      videos: [
        VideoDetails(
          url:
              'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
          description: 'A Chromecast promotional video.',
          date: '2023-01-03',
        ),
        VideoDetails(
          url:
              'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
          description: 'A video showcasing Chromecast.',
          date: '2023-01-04',
        ),
      ],
    ),
    RR(
      id: 2,
      userName: "User 3",
      videos: [
        VideoDetails(
          url:
              'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
          description: 'Promoting Chromecast features.',
          date: '2023-02-01',
        ),
        VideoDetails(
          url:
              'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
          description: 'Another Chromecast advertisement.',
          date: '2023-02-02',
        ),
      ],
    ),
    RR(
      id: 3,
      userName: "User 4",
      videos: [
        VideoDetails(
          url:
              'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
          description: 'Chromecast advertisement.',
          date: '2023-03-01',
        ),
        VideoDetails(
          url:
              'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
          description: 'A short film by Blender Foundation.',
          date: '2023-03-02',
        ),
      ],
    ),
    // Add more RR objects as needed
  ];
}


