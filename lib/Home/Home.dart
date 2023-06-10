import 'dart:async';

import 'package:asignease/Home/PopularServices.dart';
import 'package:asignease/Home/Widgets/AllPostContainer.dart';
import 'package:asignease/Home/Widgets/TopSection/TopBanner.dart';
import 'package:asignease/Search/Appdevpage.dart';
import 'package:asignease/Search/TaskInfo.dart';
import 'package:asignease/UploadTask/UploadTask.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_scrollController.hasClients) {
        final screenWidth = MediaQuery.of(context).size.width;
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final currentScrollOffset = _scrollController.offset;

        if (currentScrollOffset >= maxScrollExtent) {
          _scrollController.animateTo(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            currentScrollOffset + screenWidth,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Color(0xFFF5F5F5),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.info_outline_sharp,
              color: Colors.black,
            ),
            onPressed: () {

            },
          ),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.network(
                  "https://gingersauce.co/wp-content/uploads/2020/09/image14.png",
                  width: 60,
                ),
                // Add some spacing between the logo and text
                Text(
                  'Assignease',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Urbanist',
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Row(
                    children: [
                      Center(
                          child: TopBanner(
                              task: "Post Tasks",
                              description:
                                  "With AssignEase you know  where to  something totally possible.",
                              image:
                                  "https://cdn.pixabay.com/photo/2013/07/12/18/04/open-152933_960_720.png")),
                      SizedBox(
                        width: 30,
                      ),
                      Center(
                          child: TopBanner(
                              task: "Bid your amount",
                              description:
                                  "Enter your amount and bid for the task with as much amount you want.",
                              image:
                                  "https://cdn.pixabay.com/photo/2017/10/08/19/35/money-2831248_1280.png")),
                      Center(
                          child: TopBanner(
                              task: "Connect with a profile",
                              description:
                                  "Profiles can be checked along with criterias for a sucessfull assignment completion",
                              image:
                                  "https://cdn.pixabay.com/photo/2012/04/13/20/32/people-33542_1280.png")),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              // Divider(thickness: 1,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Match with the Ideal Service",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "With our intuitive search feature and extensive database, you can effortlessly find the perfect service that meets your unique requirements. Whether you're seeking a reliable plumber, a talented photographer, or a skilled tutor",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),


              SizedBox(
                height: 30,
              ),
            PopularServices(),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "Inspiring works made on Assignease",
                          style: TextStyle(
                            color: Color.fromRGBO(36, 107, 253, 1),
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskInfo(
                              isPopularTask: true,
                              title: "I will design top notch social media content",
                              description: "Welcome to our professional social media content design services! We pride ourselves on creating top-notch, eye-catching, and engaging content tailored to suit your brand's unique personality and target audience. With our expertise in graphic design, marketing strategies, and understanding of social media platforms, we are confident in delivering exceptional content that will captivate your followers and drive increased engagement.",
                              image: "https://fiverr-res.cloudinary.com/videos/t_main1,q_auto,f_auto/evubbjcf5gidq65ss54x/design-amazing-social-media-content-for-your-business.png", // Replace with the actual image URL
                              postedBy: "John Doe", // Replace with the actual posted by user
                              budget: 27304, // Replace with the actual budget
                              numBidders: 5, // Replace with the actual number of bidders
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Image.network(
                              "https://fiverr-res.cloudinary.com/videos/t_main1,q_auto,f_auto/evubbjcf5gidq65ss54x/design-amazing-social-media-content-for-your-business.png"),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Gig:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "I will design top notch social media content",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "7 days delivery",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "  1 Revision",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Budget:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "₹27,304",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                                softWrap: true,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskInfo(
                              isPopularTask: true,
                              title: "A quirky combination of text and illustrationts",
                              description: "Get ready to stand out from the crowd with our unique and captivating fusion of text and illustrations! We offer a one-of-a-kind social media content design service that combines witty, engaging text with visually striking illustrations, delivering a memorable experience for your audience. Our team of talented wordsmiths and creative illustrators are passionate about crafting content that sparks joy, entertains, and leaves a lasting impression. We understand the power of storytelling and know how to leverage it effectively to engage your target audience.",
                              image: "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/151504727/original/95bea31785f840dd57f5ec5d8db59fc478e471cc/create-a-quirky-combination-of-text-and-illustration.png", // Replace with the actual image URL
                              postedBy: "Mathew Davis", // Replace with the actual posted by user
                              budget: 34671, // Replace with the actual budget
                              numBidders: 13, // Replace with the actual number of bidders
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Image.network(
                              "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/151504727/original/95bea31785f840dd57f5ec5d8db59fc478e471cc/create-a-quirky-combination-of-text-and-illustration.png"),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Gig:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "A quirky combination of text and illustrationts",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "14 days delivery",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "  5 Revision",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Budget:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "₹34,671",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                                softWrap: true,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskInfo(
                              isPopularTask: true,
                              title: "Amazing product line and packaging",
                              description: "Welcome to our world of exceptional product line and packaging services, where we turn ordinary products into extraordinary experiences! We specialize in creating amazing product lines and packaging solutions that captivate consumers, reinforce brand identity, and elevate your products to new heights.",
                              image: "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs2/122589667/original/2f6145ffefac45434041b65bb86ccf79baead7c3/design-a-stunning-label-and-packaging.png", // Replace with the actual image URL
                              postedBy: "Fahad Awad", // Replace with the actual posted by user
                              budget: 77143, // Replace with the actual budget
                              numBidders: 45, // Replace with the actual number of bidders
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Image.network(
                              "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs2/122589667/original/2f6145ffefac45434041b65bb86ccf79baead7c3/design-a-stunning-label-and-packaging.png"),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Gig:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Amazing product line and packaging",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "21 days delivery",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "  1 Revision",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Budget:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "₹77,143",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                                softWrap: true,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadTask(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.black));
  }
}
