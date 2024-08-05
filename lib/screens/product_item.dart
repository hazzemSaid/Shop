import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shop/cubit/apiCubit/apicubit_cubit.dart';
import 'package:shop/models/product.dart';

class product_item extends StatelessWidget {
  @override
  bool loading = true;

  Widget build(BuildContext context) {
    return BlocConsumer<ApiCubit, ApicubitState>(
      listener: (context, state) {
        if (state is ApicubitError_singleCategory) {
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
        if (state is ApicubitLoading) {
          loading = true;
        } else {
          loading = false;
        }
      },
      builder: (context, state) {
        loading = true;
        Product? data = BlocProvider.of<ApiCubit>(context).item;
        if (state is ApicubitSuccess_singleProdcut) {
          data = state.data;

          loading = false;
        }

        return ModalProgressHUD(
          inAsyncCall: loading,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    '${data?.title}',
                    style: TextStyle(fontSize: 20),
                  ),
                  FanCarouselImageSlider.sliderType1(
                    imagesLink: data!.images,
                    isAssets: false,
                    autoPlay: false,
                    sliderHeight: 400,
                    showIndicator: true,
                  ),
                  Text(
                    'Price: ${data?.price}',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Description: ${data?.description.substring(14, 100)}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
