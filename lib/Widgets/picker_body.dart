import 'package:chat_app/models/image_model.dart';
import 'package:flutter/material.dart';

import '../repo/image_repository.dart';

class NetworkImagePickerBody extends StatelessWidget {
  NetworkImagePickerBody({super.key,required this.onImageSelected});

  final Function(String) onImageSelected;

  final ImageRepository _imageRepo = ImageRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: FutureBuilder<List<PixelfordImage>>(
        future: _imageRepo.getNetworkImages(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PixelfordImage>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    onImageSelected(snapshot.data![index].urlSmallSize);
                  },
                  child: Image.network(snapshot.data![index].urlSmallSize),
                );
              },
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
              ),
            );
          } else if(snapshot.hasError){
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }
          else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: const CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
