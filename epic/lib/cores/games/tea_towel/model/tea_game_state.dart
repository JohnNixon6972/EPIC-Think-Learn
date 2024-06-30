import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/tea_towel/model/item.dart';
import 'package:flutter/material.dart';

class TeaGameState {
  final List<Item> objects = [
    Item(name: "Backpack", image: "assets/images/game_images/backpack.png"),
    Item(name: "Phone", image: "assets/images/game_images/phone.png"),
    Item(name: "Wallet", image: "assets/images/game_images/wallet.png"),
    Item(name: "Keys", image: "assets/images/game_images/keys.png"),
    Item(name: "Glasses", image: "assets/images/game_images/glasses.png"),
    Item(name: "Pen", image: "assets/images/game_images/pen.png"),
    Item(name: "Notebook", image: "assets/images/game_images/notebook.png"),
    Item(name: "Laptop", image: "assets/images/game_images/laptop.png"),
    Item(name: "Coffee mug", image: "assets/images/game_images/coffee_mug.png"),
    Item(
        name: "Water bottle",
        image: "assets/images/game_images/water_bottle.png"),
    Item(name: "Watch", image: "assets/images/game_images/watch.png"),
    Item(name: "Bed", image: "assets/images/game_images/bed.png"),
    Item(name: "Shoes", image: "assets/images/game_images/shoes.png"),
    Item(name: "T-shirt", image: "assets/images/game_images/t-shirt.png"),
    Item(
        name: "Remote control",
        image: "assets/images/game_images/remote_control.png"),
    Item(name: "Headphones", image: "assets/images/game_images/headphones.png"),
    Item(name: "Chair", image: "assets/images/game_images/chair.png"),
    Item(name: "Lamp", image: "assets/images/game_images/lamp.png"),
    Item(name: "Spoon", image: "assets/images/game_images/spoon.png"),
    Item(name: "Pillow", image: "assets/images/game_images/pillow.png"),
  ];

  List<String> userSelectedItems = [];
  List<Item> currentItems = [];
  List<String> currentItemNames = [];

  String? message;
  String? query;

  int score;
  Duration? elapsedTime;
  Duration? visibleTime;
  bool isGameOver;
  bool isGameWon;
  Color backgroundColor;
  bool isItemSelection;

  TeaGameState({
    this.score = 0,
    this.isGameOver = true,
    this.isGameWon = false,
    this.visibleTime = Duration.zero,
    this.isItemSelection = false,
    this.userSelectedItems = const [],
    this.currentItems = const [],
    this.currentItemNames = const [],
    this.backgroundColor = AppConstants.memoryColor,
    this.elapsedTime = Duration.zero,
    this.query = "",
    this.message = "",
  });

  TeaGameState copyWith({
    List<String>? userSelectedItems,
    List<Item>? currentItems,
    List<String>? currentItemNames,
    Color? backgroundColor,
    Duration? elapsedTime,
    bool? isGameWon,
    String? query,
    String? message,
    bool? isGameOver,
    bool? isItemSelection,
    int? score,
    Duration? visibleTime,
  }) {
    return TeaGameState(
      userSelectedItems: userSelectedItems ?? this.userSelectedItems,
      currentItems: currentItems ?? this.currentItems,
      currentItemNames: currentItemNames ?? this.currentItemNames,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      isGameWon: isGameWon ?? this.isGameWon,
      isGameOver: isGameOver ?? this.isGameOver,
      query: query ?? this.query,
      message: message ?? this.message,
      score: score ?? this.score,
      isItemSelection: isItemSelection ?? this.isItemSelection,
      visibleTime: visibleTime ?? this.visibleTime,
    );
  }
}
