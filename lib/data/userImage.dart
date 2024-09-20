import 'package:flutter/material.dart';

DecorationImage userImage() {
  return DecorationImage(
    fit: BoxFit.cover,
    image: NetworkImage(
      "https://images.unsplash.com/photo-1541647376583-8934aaf3448a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80",
    ),
  );
}
