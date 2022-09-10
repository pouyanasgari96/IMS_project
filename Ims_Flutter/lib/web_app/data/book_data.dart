
import 'package:flutter/material.dart';

import '../model/item.dart';
//local items list
final allItems = <Item> [
  Item(
    id: "1", 
    author: 'miamai', 
    title: 'heyyo',
    urlImage: 'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
    color: Colors.green.withOpacity(0.5),
    price: 20.0,
    description: "NEEDED DESCRIPTION!\nAnyway we are very poor, please buy it <3",
    available: true,
    favorite: false,
    location: "saint july",
    category: "Fantasy",
  ),
  Item(
    id: "2", 
    author: 'miamai', 
    title: 'hefsafs',
    urlImage: 'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
    color: Colors.green.withOpacity(0.5),
    price: 20.0,
    description: "NEEDED DESCRIPTION!\nAnyway we are very poor, please buy it <3",
    available: true,
    favorite: false,
    location: "saint july",
    category: "Horror",
  ),

  Item(
    id: "3", 
    author: 'miamai', 
    title: 'heasfffo',
    urlImage: 'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
   color: Colors.green.withOpacity(0.5),
   price: 20.0,
   description: "NEEDED DESCRIPTION!\nAnyway we are very poor, please buy it <3",
   available: false,
   favorite: false,
   location: "saint july",
   category: "Romance",
  ),
  Item(
    id: "4", 
    author: 'miamai', 
    title: 'hrbjqk',
    urlImage: 'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
    color: Colors.green.withOpacity(0.5),
    description: "NEEDED DESCRIPTION!\nAnyway we are very poor, please buy it <3",
    price: 20.0,
    available: true,
    favorite: false,
    location: "saint july",
    category: "Romance",
  ),
  Item(
    id: "5", 
    author: 'miamai', 
    title: 'hehhoo',
    urlImage: 'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
    color:Colors.green.withOpacity(0.5),
    price: 20.0,
    description: "NEEDED DESCRIPTION!\nAnyway we are very poor, please buy it <3",
    available: false,
    favorite: false,
    location: "saint july",
    category: "Romance",
  ),
  Item(
    id: "6", 
    author: 'miamai', 
    title: 'heasfa',
    urlImage: 'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
    color: Colors.green.withOpacity(0.5),
    price: 20.0,
    description: "NEEDED DESCRIPTION!\nAnyway we are very poor, please buy it <3",
    available: true,
    favorite: false,
    location: "saint july",
    category: "Horro",
  ),
  Item(
    id: "7", 
    author: 'miamai', 
    title: 'he03aa',
    urlImage: 'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
    color: Colors.green.withOpacity(0.5),
    price: 20.0,
    description: "NEEDED DESCRIPTION!\nAnyway we are very poor, please buy it <3",
    available: false,
    favorite: false,
    location: "saint july",
    category: "Horror",
  ),
];

// Pending items list

var pendingItems = <Item>[];

  


