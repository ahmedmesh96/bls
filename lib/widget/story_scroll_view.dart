import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class StoryScrollView extends StatefulWidget {
  const StoryScrollView({super.key});

  @override
  State<StoryScrollView> createState() => _StoryScrollViewState();
}

class _StoryScrollViewState extends State<StoryScrollView> {
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    final double heightScreen = MediaQuery.of(context).size.height;
    final allDataFromDB = Provider.of<UserProvider>(context).getUser;

    return 
    
    
    
    
    
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      
      child: Row(children: [
        Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(125, 78, 91, 110)),
                      child: CircleAvatar(
                        radius: widthScreen > 600
                            ? widthScreen * 0.06
                            : widthScreen * 0.07,
                        backgroundImage:
                            NetworkImage(allDataFromDB!.profileImg),
                      ),
                    ),

                      Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(124, 255, 0, 0)),
                      child: CircleAvatar(
                        radius: widthScreen > 600
                            ? widthScreen * 0.06
                            : widthScreen * 0.07,
                        backgroundImage:
                            const NetworkImage("https://mymodernmet.com/wp/wp-content/uploads/2019/12/photos-of-indonesia-rarindra-prakarsa-4.jpg"),
                      ),
                    ),
                     Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(124, 255, 0, 0)),
                      child: CircleAvatar(
                        radius: widthScreen > 600
                            ? widthScreen * 0.06
                            : widthScreen * 0.07,
                        backgroundImage:
                            const NetworkImage("https://iso.500px.com/wp-content/uploads/2016/02/stock-photo-114337435-1500x1000.jpg"),
                      ),
                    ), Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(123, 255, 0, 0)),
                      child: CircleAvatar(
                        radius: widthScreen > 600
                            ? widthScreen * 0.06
                            : widthScreen * 0.07,
                        backgroundImage:
                            const NetworkImage("https://www.befunky.com/images/prismic/318d2218-716f-4dd6-a95d-9fa409ec447e_landing-photo-to-cartoon-img4.jpeg?auto=avif,webp&format=jpg&width=863"),
                      ),
                    ), Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(123, 255, 0, 0)),
                      child: CircleAvatar(
                        radius: widthScreen > 600
                            ? widthScreen * 0.06
                            : widthScreen * 0.07,
                        backgroundImage:
                            const NetworkImage("https://burst.shopifycdn.com/photos/incredible-balance-yoga-posing.jpg?width=1200&format=pjpg&exif=0&iptc=0"),
                      ),
                    ), Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(125, 78, 91, 110)),
                      child: CircleAvatar(
                        radius: widthScreen > 600
                            ? widthScreen * 0.06
                            : widthScreen * 0.07,
                        backgroundImage:
                            const NetworkImage("https://media.istockphoto.com/photos/business-man-pushing-large-stone-up-to-hill-business-heavy-tasks-and-picture-id825383494?k=20&m=825383494&s=612x612&w=0&h=tEqZ5HFZcM3lmDm_cmI7hOeceiqy9gYrkyLTTkrXdY4="),
                      ),
                    ), Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(125, 78, 91, 110)),
                      child: CircleAvatar(
                        radius: widthScreen > 600
                            ? widthScreen * 0.06
                            : widthScreen * 0.07,
                        backgroundImage:
                            const NetworkImage("https://i0.wp.com/www.alphr.com/wp-content/uploads/2020/03/How-to-Add-photos-to-TikTok.jpg?fit=1000%2C666&ssl=1"),
                      ),
                    ),
                     Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(125, 78, 91, 110)),
                      child: CircleAvatar(
                        radius: widthScreen > 600
                            ? widthScreen * 0.06
                            : widthScreen * 0.07,
                        backgroundImage:
                            const NetworkImage("https://st4.depositphotos.com/3047599/20399/i/600/depositphotos_203995514-stock-photo-beautiful-display-colorful-hanging-umbrellas.jpg"),
                      ),
                    ),
                     Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(125, 78, 91, 110)),
                      child: CircleAvatar(
                        radius: widthScreen > 600
                            ? widthScreen * 0.06
                            : widthScreen * 0.07,
                        backgroundImage:
                            const NetworkImage("https://assets-global.website-files.com/5a016d51240da900013d2ea2/5fc8e1f4bc8a02aecf06f035_eyeem-23716958-121079333-(1)%20(1).png"),
                      ),
                    ),
                     Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(125, 78, 91, 110)),
                      child: CircleAvatar(
                        radius: widthScreen > 600
                            ? widthScreen * 0.06
                            : widthScreen * 0.07,
                        backgroundImage:
                            const NetworkImage("https://www.rollingstone.com/wp-content/uploads/2021/12/Travis-Barker-by-Samuel-Trotter-IMG_7457.jpg?w=800"),
                      ),
                    ),
                    
      ]),
    );
  }
}
