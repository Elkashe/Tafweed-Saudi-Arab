import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/cubits/prices/price_cubit.dart';

class PackageCard extends StatefulWidget {
  final String text;
  final double price;
  final String image;
  final Function() onTap;
  const PackageCard({super.key, required this.text, required this.image, required this.onTap, required this.price});

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  String workingImage = "assets/images/kaaba2.jpg";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    workingImage = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    var priceCubit = BlocProvider.of<PriceCubit>(context);
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: widget.onTap,
      child: Container(
        //height: 80,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            opacity: 0.15,
            fit: BoxFit.cover,
            image: NetworkImage(widget.image),
            onError: (o, s){
              workingImage = "assets/images/kaaba2.jpg";
              setState(() {});
            }
          )
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${priceCubit.currency.sign} ${((widget.price * priceCubit.currency.rate).ceilToDouble()).toStringAsFixed(1)} ",
                  style: const TextStyle(
                    //fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}