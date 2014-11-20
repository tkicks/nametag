// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';         // imports all of the dart built-in functions
import 'dart:math' show Random;   // imports Random from the math library

ButtonElement genButton;

void main() {
  querySelector('#inputName').onInput.listen(updateBadge);
  /*
  * querySelector() defined in dart:html
  * listen() is an asynchronous stream registering a callback when there's new data
  * onInput.listen() means that when there's new input listen to the input and put it into param
  * param is updateBadge
  * updateBadge is called when there is new data added to the importName id from the html document
  */

  genButton = querySelector('#generateNameButton');
  genButton.onClick.listen(generateName);
  /*
  * ButtonElement genButton is a global variable (top-level)
  * genButton assigned to the element with id generateNameButton
  * when the button is clicked as indicated by the listener call generateName
  */
}

void updateBadge(Event e) {

  String inputName = (e.target as InputElement).value;
  setBadgeName(new PirateName(firstName: inputName));
  /*
  * sets a string var inputName to the name being inputted by user
  * passes a new instance of PirateName with optional firstName param (inputName)
  * to setter to set the badge to it
  */

  if (inputName.trim().isEmpty) {
    genButton..disabled = false
         ..text = "Capn's choice";
  }
  /*
  * .trim() removes whitespace at end
  * .isEmpty checks if there is text in the inputName form
  * .. allows for more than one property to be set to the button
  */

  else {
    genButton..disabled = true
         ..text = "I know yer name";
  }
  /*
  * .. allows for more than one property to be set to the button
  */
}


void setBadgeName(PirateName newName) {
  querySelector('#badgeName').text = newName.pirateName;
  /*
  * sets the element with the id badgeName's text to the PirateName passed in
  * from generateName
  */
}

void generateName(Event e) {
  setBadgeName(new PirateName());
  /*
  * generates the name of the badge to be the string passed to the setter
  */
}

class PirateName {
  static final Random indexGen = new Random();
  /*
  * static means it's share with al instances of the class
  * final means it's never going to change
  *   -> indexGen is a variable of type Random that is never going to change from random
  */

  String _firstName;
  String _appellation;
  /*
  * varType _varName = private variable b/c of _ (no 'private')
  */

  static final List names = [
  'Tyler', 'Kim', 'Alek', 'Meg', 'Corinne', 'Brittany', 'Dan', 'Stefan', 'Andrew',
  'Will', 'Angie', 'Emily', 'Noah', 'Brian'];
  static final List appellations = [
  'Jackal', 'King', 'Red', 'Stalwart', 'Young', 'Brave', 'Eager', 'Wily',
  'Zesty', 'Speedy', 'Bumbling', 'Stumbling', 'Queen', 'Sleepy', 'Master',
  'Trainer', 'Forgotten', 'Revered', 'Indecisive', 'Turtle'];
  /*
  * List class literals of random names and appellations
  */

  PirateName({String firstName, String appellation}) {
    /*
    * PirateName constructor
    * takes in the inputted name and an appellation
    */
    if (firstName == null) {
      _firstName = names[indexGen.nextInt(names.length)];
    }
    /*
    * if the name passed in is null ie the user didn't type in anything
    * set the _firstName variable to a random first name from the list
    * nextInt generates a new Random number from 0 to the length of the list
    *   sets _firstName to the name in the List at index generated
    */
    else {
      _firstName = firstName;
    }
    /*
    * if the user did input to the form, set _firstName to the input
    */

    if (appellation == null) {
      _appellation = appellations[indexGen.nextInt(appellations.length)];
    }
    else {
      _appellation = appellation;
    }
    /*
    * same as with firstName
    */
  }

  String get pirateName => _firstName.isEmpty ? '' : '$_firstName the $_appellation';
  /*
  * get = getter function pirateName returning a string
  * => == return the following
  *   ? = if else so if _firstName isEmpty return nothing if it's full return
  *   the string interpolation ($) to add the string variables to the string pirateName
  */
}