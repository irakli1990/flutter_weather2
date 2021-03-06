import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunshine/backend/city/bloc.dart';


// city selection and city list widget
class CitySelection extends StatefulWidget {
  @override
  State<CitySelection> createState() => _CitySelectionState();
}

class _CitySelectionState extends State<CitySelection> {
  final TextEditingController _textController = TextEditingController();
  CityBloc _cityBloc;

  @override
  Widget build(BuildContext context) {
    _cityBloc = BlocProvider.of<CityBloc>(context)..add(LoadCities());
    return Scaffold(
      appBar: AppBar(
        title: Text('City'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _textController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'City',
                            hintText: 'Sosnowiec',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                Navigator.pop(context, _textController.text);
                              },
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<CityBloc, CityState>(
              builder: (context, state) {
                if (state is CityLoaded) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Dismissible(
                            background: Container(
                                alignment: Alignment.centerRight,
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                )),
                            key: Key(state.cities[index].cityName),
                            child: Card(
                              child: ListTile(
                                title: Text(state.cities[index].cityName),
                                leading: Icon(Icons.check_circle,
                                    color: Colors.green),
                              ),
                            ),
                            onDismissed: (_) {
                              setState(() {
                                BlocProvider.of<CityBloc>(context)
                                  ..add(DeleteCity(state.cities[index]));
                              });
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "${state.cities[index].cityName} deleted")));
                            },
                          ),
                          onTap: () {
                            setState(() {
                              _textController.text =
                                  state.cities[index].cityName;
                            });
                            Navigator.pop(context, _textController.text);
                          },
                        );
                      },
                      shrinkWrap: true,
                      itemCount: state.cities.length,
                    ),
                  );
                }
                return Text("no favorite cities");
              },
            ),
          ],
        ),
      ),
    );
  }
}
