// ignore: file_names
import 'dart:ffi';

class Artist {
  String? id;
  String? name;
  String? imageUrl;
  Long? followers;
  String? genre;

  Artist({
    this.id,
    this.name,
    this.imageUrl,
    this.followers,
    this.genre
  });

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['images'][0]['url'];
    followers = json['followers']['total'];
    genre = json['genres'][0];
  }
}


// var defaultArtistsList = [
//   Artist(
//       id: "1DjZI46mVZZZYmmmygRnTw",
//       name: "Reality Club",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5ebcb925d1cd51e4604cc97304d",
//       followers: 402484,
//       genre: "Indonesian Indie"),
//   Artist(
//       id: "51kyrUsAVqUBcoDEMFkX12",
//       name: "Hindia",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5eb324cea967a456ee680bf6b92",
//       followers: 2618293,
//       genre: "Indonesian Pop"),
//   Artist(
//       id: "1DjZI46mVZZZYmmmygRnTw",
//       name: "Reality Club",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5ebcb925d1cd51e4604cc97304d",
//       followers: 402484,
//       genre: "Indonesian Indie"),
//   Artist(
//       id: "51kyrUsAVqUBcoDEMFkX12",
//       name: "Hindia",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5eb324cea967a456ee680bf6b92",
//       followers: 2618293,
//       genre: "Indonesian Pop"),
//   Artist(
//       id: "1DjZI46mVZZZYmmmygRnTw",
//       name: "Reality Club",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5ebcb925d1cd51e4604cc97304d",
//       followers: 402484,
//       genre: "Indonesian Indie"),
//   Artist(
//       id: "51kyrUsAVqUBcoDEMFkX12",
//       name: "Hindia",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5eb324cea967a456ee680bf6b92",
//       followers: 2618293,
//       genre: "Indonesian Pop"),
//   Artist(
//       id: "1DjZI46mVZZZYmmmygRnTw",
//       name: "Reality Club",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5ebcb925d1cd51e4604cc97304d",
//       followers: 402484,
//       genre: "Indonesian Indie"),
//   Artist(
//       id: "51kyrUsAVqUBcoDEMFkX12",
//       name: "Hindia",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5eb324cea967a456ee680bf6b92",
//       followers: 2618293,
//       genre: "Indonesian Pop"),
//   Artist(
//       id: "1DjZI46mVZZZYmmmygRnTw",
//       name: "Reality Club",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5ebcb925d1cd51e4604cc97304d",
//       followers: 402484,
//       genre: "Indonesian Indie"),
//   Artist(
//       id: "51kyrUsAVqUBcoDEMFkX12",
//       name: "Hindia",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5eb324cea967a456ee680bf6b92",
//       followers: 2618293,
//       genre: "Indonesian Pop"),
//   Artist(
//       id: "1DjZI46mVZZZYmmmygRnTw",
//       name: "Reality Club",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5ebcb925d1cd51e4604cc97304d",
//       followers: 402484,
//       genre: "Indonesian Indie"),
//   Artist(
//       id: "51kyrUsAVqUBcoDEMFkX12",
//       name: "Hindia",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5eb324cea967a456ee680bf6b92",
//       followers: 2618293,
//       genre: "Indonesian Pop"),
//   Artist(
//       id: "1DjZI46mVZZZYmmmygRnTw",
//       name: "Reality Club",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5ebcb925d1cd51e4604cc97304d",
//       followers: 402484,
//       genre: "Indonesian Indie"),
//   Artist(
//       id: "51kyrUsAVqUBcoDEMFkX12",
//       name: "Hindia",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5eb324cea967a456ee680bf6b92",
//       followers: 2618293,
//       genre: "Indonesian Pop"),
//   Artist(
//       id: "1DjZI46mVZZZYmmmygRnTw",
//       name: "Reality Club",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5ebcb925d1cd51e4604cc97304d",
//       followers: 402484,
//       genre: "Indonesian Indie"),
//   Artist(
//       id: "51kyrUsAVqUBcoDEMFkX12",
//       name: "Hindia",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5eb324cea967a456ee680bf6b92",
//       followers: 2618293,
//       genre: "Indonesian Pop"),
//   Artist(
//       id: "1DjZI46mVZZZYmmmygRnTw",
//       name: "Reality Club",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5ebcb925d1cd51e4604cc97304d",
//       followers: 402484,
//       genre: "Indonesian Indie"),
//   Artist(
//       id: "51kyrUsAVqUBcoDEMFkX12",
//       name: "Hindia",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5eb324cea967a456ee680bf6b92",
//       followers: 2618293,
//       genre: "Indonesian Pop"),
//   Artist(
//       id: "1DjZI46mVZZZYmmmygRnTw",
//       name: "Reality Club",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5ebcb925d1cd51e4604cc97304d",
//       followers: 402484,
//       genre: "Indonesian Indie"),
//   Artist(
//       id: "51kyrUsAVqUBcoDEMFkX12",
//       name: "Hindia",
//       imageUrl:
//           "https://i.scdn.co/image/ab6761610000e5eb324cea967a456ee680bf6b92",
//       followers: 2618293,
//       genre: "Indonesian Pop"),
// ];
