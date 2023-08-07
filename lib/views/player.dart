import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/const/const.dart';
import 'package:music/const/text_style.dart';
import 'package:music/controller/pleyarcontroller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              ()=> Expanded(
                  child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 300,
                      width: 300,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: QueryArtworkWidget(
                        id: data[controller.playIndex.value].id,
                        type: ArtworkType.AUDIO,
                        artworkHeight: double.infinity,
                        artworkWidth: double.infinity,
                        nullArtworkWidget: const Icon(
                          Icons.music_note,
                          size: 48,
                          color: whiteColor,
                        ),
                      ))),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ), // BorderRadius. vertical
                ),
                child: Obx(
                  ()=>Column(
                    children: [
                      Text(
                        data[controller.playIndex.value].displayName,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: ourStyle(
                          color: bgDarkColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        data[controller.playIndex.value].artist.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: ourStyle(
                          color: bgDarkColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              controller.position.value,
                              style: ourStyle(
                                color: bgDarkColor,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                thumbColor: sliderColor,
                                inactiveColor: bgColor,
                                activeColor: sliderColor,
                                min: const Duration(seconds: 0).inSeconds.toDouble(),
                                max: controller.max.toDouble(),
                                value: controller.value.value,
                                onChanged: (newValue) {
                                  controller.changeDuration(newValue.toInt());
                                  newValue = newValue;
                                },
                              ),
                            ),
                            Text(
                              controller.duration.value,
                              style: ourStyle(
                                color: bgDarkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.playSong(
                                    data[controller.playIndex.value-1].uri,
                                    controller.playIndex.value-1);
                              },
                              icon: const Icon(
                                Icons.skip_previous_rounded,
                                size: 40,
                                color: bgDarkColor,
                              )),
                          Obx(
                            () => CircleAvatar(
                              radius: 35,
                              backgroundColor: bgDarkColor,
                              child: Transform.scale(
                                scale: 2.5,
                                child: IconButton(
                                    onPressed: () {
                                      if (controller.isPlaying.value) {
                                        controller.audioPlayer.pause();
                                        controller.isPlaying(false);
                                      } else {
                                        controller.audioPlayer.play();
                                        controller.isPlaying(true);
                                      }
                                    },
                                    icon: controller.isPlaying.value
                                        ? const Icon(
                                            Icons.pause,
                                            color: whiteColor,
                                          )
                                        : const Icon(
                                            Icons.play_arrow_rounded,
                                            color: whiteColor,
                                          )),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.playSong(
                                    data[controller.playIndex.value+1].uri,
                                    controller.playIndex.value+1);
                              
                              },
                              icon: const Icon(
                                Icons.skip_next_rounded,
                                size: 40,
                                color: bgDarkColor,
                              )),
                        ],
                      ), // Row
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
