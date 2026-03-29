import 'package:get/get.dart';

class HomeController extends GetxController {
  // Bottom navigation
  var currentIndex = 0.obs;
  
  // Search functionality
  var searchController = Get.find<SearchController>();
  var isSearching = false.obs;
  var searchQuery = ''.obs;
  
  // Posts data
  var posts = <Post>[].obs;
  var isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }
  
  void loadPosts() {
    isLoading.value = true;
    
    // Simulate API call with sample data
    Future.delayed(const Duration(seconds: 2), () {
      posts.addAll([
        Post(
          id: '1',
          username: 'john_doe',
          userProfileImage: 'assets/images/user1.jpg',
          image: 'assets/images/post1.jpg',
          caption: 'Beautiful sunset at the beach! 🌅',
          likes: 234,
          comments: 45,
          timestamp: '2 hours ago',
          isLiked: false,
        ),
        Post(
          id: '2',
          username: 'jane_smith',
          userProfileImage: 'assets/images/user2.jpg',
          image: 'assets/images/post2.jpg',
          caption: 'Coffee and coding - perfect combination! ☕💻',
          likes: 567,
          comments: 89,
          timestamp: '4 hours ago',
          isLiked: true,
        ),
        Post(
          id: '3',
          username: 'mike_wilson',
          userProfileImage: 'assets/images/user3.jpg',
          image: 'assets/images/post3.jpg',
          caption: 'Nature never goes out of style 🌲',
          likes: 123,
          comments: 23,
          timestamp: '6 hours ago',
          isLiked: false,
        ),
      ]);
      isLoading.value = false;
    });
  }
  
  void changeTab(int index) {
    currentIndex.value = index;
  }
  
  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchQuery.value = '';
    }
  }
  
  void onSearchChanged(String query) {
    searchQuery.value = query;
  }
  
  void toggleLike(String postId) {
    final post = posts.firstWhereOrNull((p) => p.id == postId);
    if (post != null) {
      post.isLiked = !post.isLiked;
      post.likes += post.isLiked ? 1 : -1;
      posts.refresh();
    }
  }
  
  void refreshPosts() {
    posts.clear();
    loadPosts();
  }
}

class Post {
  String id;
  String username;
  String userProfileImage;
  String image;
  String caption;
  int likes;
  int comments;
  String timestamp;
  bool isLiked;
  
  Post({
    required this.id,
    required this.username,
    required this.userProfileImage,
    required this.image,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.timestamp,
    required this.isLiked,
  });
}

class SearchController extends GetxController {
  var searchQuery = ''.obs;
  var searchResults = <String>[].obs;
  
  void onSearchChanged(String query) {
    searchQuery.value = query;
    if (query.isNotEmpty) {
      // Simulate search results
      searchResults.value = [
        'Search result 1 for $query',
        'Search result 2 for $query',
        'Search result 3 for $query',
      ];
    } else {
      searchResults.clear();
    }
  }
}
