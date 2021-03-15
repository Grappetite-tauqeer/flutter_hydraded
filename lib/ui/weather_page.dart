
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../weather/weather/weather_bloc.dart';
import 'package:flutter_hydraded/Model/weather.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherBlock = WeatherBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //weatherBlock.dispose();
    weatherBlock.close();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fake Weather App'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocProvider(
          create: (BuildContext context) => weatherBlock,
          child: BlocBuilder<WeatherBloc , WeatherState>(
            cubit: weatherBlock,
            builder: (context , state){

              if (state is WeatherInitial){
                return buildInitialInput();
              }
              else if (state is WeatherLoading){
                return buildLoading();
              }
              else if (state is WeatherLoaded){
                return buildColumn(state.weather);
              }

              return Container();


            },
          ),

        ),
      ),
    );
  }

  Widget buildInitialInput(){
    return Center(
      child: CityInputField(),
    );

  }

  Widget buildLoading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  Column buildColumn(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(weather.cityName ,
          style: TextStyle(
              fontSize: 40 , fontWeight: FontWeight.w700
          ),),
        Text(
          '${weather.temperature.toStringAsFixed(1)} C' ,
          style: TextStyle(
            fontSize: 80,
          ),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatefulWidget {
  @override
  _CityInputFieldState createState() => _CityInputFieldState();
}

class _CityInputFieldState extends State<CityInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (cityName) {
          WeatherBloc _contactBloc = BlocProvider.of<WeatherBloc>(context);
          _contactBloc.add(GetWeather(cityName));


        }
        ,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city" ,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffix: Icon(Icons.search),

        ),
      ),
    );
  }
}

