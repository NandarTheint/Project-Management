import 'package:flutter/material.dart';

// Text style of project card
const projectCardTextStyle = TextStyle(color: Colors.black, fontSize: 17);

// Text style for project ID
const projectIDTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
);

// status of projects
enum Status { notStarted, onProgress, finished }

// assign constant key for status of projects
const statusNotStarted = 1;
const statusOnProgress = 2;
const statusFinished = 3;

// Decoration for authenticate text fields
const authenticateTextDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromARGB(255, 6, 108, 101),
      width: 4.0,
    ),
  ),
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter your email',
  focusColor: Color.fromARGB(255, 4, 42, 38),
);
