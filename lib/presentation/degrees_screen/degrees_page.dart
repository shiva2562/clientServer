import 'package:clientserver/Bloc/degrees_bloc/degrees_bloc.dart';
import 'package:clientserver/Bloc/fields_bloc/fields_bloc.dart';
import 'package:clientserver/Model/education_degree.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DegreesPage extends StatefulWidget {
  final String text;
  const DegreesPage(this.text, {super.key});

  @override
  State<DegreesPage> createState() => _DegreesPageState();
}

class _DegreesPageState extends State<DegreesPage> {
  @override
  void initState() {
    BlocProvider.of<DegreesBloc>(context).add(GetDegrees());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<DegreesBloc, DegreesState>(
                builder: (context, state) {
                  if (state is DegreesSuccess) {
                    BlocProvider.of<FieldsBloc>(context)
                        .add(GetFields(state.currentValue));
                    return DropdownButton(
                        items: state.degrees.map((e) {
                          return DropdownMenuItem(
                              value: e.id, child: Text(e.degree));
                        }).toList(),
                        value: state.currentValue,
                        onChanged: ((value) {
                          setState(() {
                            state.setCurrentValue = value ?? 0;
                          });
                        }));
                  } else if (state is DegreesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Center(
                    child: Text("something went wrong cannot get the data"),
                  );
                },
              ),
              BlocBuilder<FieldsBloc, FieldsState>(
                builder: (context, state) {
                  if (state is FieldsSuccess) {
                    return Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: state.fields.map((e) {
                          return Text("${e.type} ");
                        }).toList(),
                      ),
                    );
                    // return DropdownButton(
                    //     items: state.fields.map((e) {
                    //       return DropdownMenuItem(
                    //           value: e.type, child: Text(e.type));
                    //     }).toList(),
                    //     value: state.currentValue,
                    //     onChanged: ((value) {
                    //       setState(() {
                    //         state.setCurrentValue = value ?? "";
                    //       });
                    //     }));
                  } else if (state is FieldsLoading || state is FieldsInitial) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Center(
                    child: Text("something went wrong cannot get the data"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
