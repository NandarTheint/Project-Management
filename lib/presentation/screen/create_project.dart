import 'package:flutter/material.dart';
import 'package:project_management/application/service/firebaseDatabase_service.dart';
import 'package:project_management/component/project_textfformfield.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_management/domain/model/project.dart';

import '../../application/service/auth_service.dart';

class CreateProject extends StatefulWidget {
  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final AuthService _authenticate = AuthService();
  final DataBaseService _dataBaseService = DataBaseService();
  final _formKey = GlobalKey<FormBuilderState>();

  void _createProject() {
    Project proj = Project(
        projectID: _formKey.currentState?.fields['ProjectID']!.value,
        projectName: _formKey.currentState?.fields['ProjectName']!.value,
        projectStartDate:
            _formKey.currentState?.fields['ProjectStartDate']!.value,
        projectEndDate: _formKey.currentState?.fields['ProjectEndDate']!.value,
        status: 0);
    _dataBaseService.create(proj);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool _ProjIDHasError = false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: const Text('CREATE PROJECT'),
        actions: <Widget>[
          TextButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.grey[400]),
            ),
            onPressed: () async {
              await _authenticate.signOut();
            },
            icon: const Icon(Icons.person),
            label: const Text('Logout'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                onChanged: () {
                  _formKey.currentState!.save();
                  debugPrint(_formKey.currentState!.value.toString());
                },
                autovalidateMode: AutovalidateMode.disabled,
                skipDisabled: true,
                child: Column(
                  children: <Widget>[
                    // project ID
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (val) {
                        setState(() {
                          _ProjIDHasError = _formKey
                                  .currentState?.fields['ProjectID']
                                  ?.validate() ??
                              false;
                        });
                      },
                      name: 'ProjectID',
                      decoration: const InputDecoration(
                        labelText: 'Project ID',
                      ),

                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Project Name
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (val) {
                        setState(() {
                          _ProjIDHasError = _formKey
                                  .currentState?.fields['ProjectName']
                                  ?.validate() ??
                              false;
                        });
                      },
                      name: 'ProjectName',
                      decoration: const InputDecoration(
                        labelText: 'Project Name',
                      ),

                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // project start date
                    FormBuilderDateTimePicker(
                      name: 'ProjectStartDate',
                      inputType: InputType.date,
                      // initialValue: DateTime.now(),
                      decoration: const InputDecoration(
                        labelText: 'Project Start Date',
                      ),
                      initialValue: null,
                      resetIcon: null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormBuilderDateTimePicker(
                      name: 'ProjectEndDate',
                      inputType: InputType.date,
                      // initialValue: DateTime.now(),
                      decoration: const InputDecoration(
                        labelText: 'Project End Date',
                      ),
                      initialValue: null,
                      resetIcon: null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data....')),
                        );
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          _createProject();
                        } else {
                          debugPrint(_formKey.currentState?.value.toString());
                          debugPrint('validation failed');
                          return;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal[300],
                        fixedSize: const Size(160, 30),
                      ),
                      child: const Text('Create Project'),
                    ),
                  ],
                ),
              ),
            ],

            // formaer textformfields
            // children: <Widget>[
            //   ProjectTextFormField(
            //     callBack: (val) => setState(() {
            //       projId = val;
            //     }),
            //     labelText: 'Project ID',
            //   ),
            //   const SizedBox(
            //     height: 20.0,
            //   ),
            //   ProjectTextFormField(
            //     callBack: (val) => setState(() {
            //       projName = val;
            //     }),
            //     labelText: 'Project Name',
            //   ),
            //   const SizedBox(
            //     height: 20.0,
            //   ),
            //   ProjectTextFormField(
            //     callBack: (val) => setState(() {
            //       projStartDate = val;
            //     }),
            //     labelText: 'Project Start Date',
            //   ),
            //   const SizedBox(
            //     height: 20.0,
            //   ),
            //   ProjectTextFormField(
            //     callBack: (val) => setState(() {
            //       projEndDate = val;
            //     }),
            //     labelText: 'Project End Date',
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 30.0),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           const SnackBar(content: Text('Processing Data....')),
            //         );
            //       },
            //       style: ElevatedButton.styleFrom(
            //         primary: Colors.teal[300],
            //         fixedSize: const Size(160, 30),
            //       ),
            //       child: const Text('Create Project'),
            //     ),
            //   ),
            // ],
          ),
        ),
      ),
    );
  }
}
