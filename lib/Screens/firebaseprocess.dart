import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProcess extends StatefulWidget {
  @override
  _FirebaseProcessState createState() => _FirebaseProcessState();
}

class _FirebaseProcessState extends State<FirebaseProcess> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: Text('Firebase Veri İşlemleri'),
        backgroundColor: Colors.blueGrey.shade900, // AppBar arka plan rengi olarak mavi kullanıldı
      ),
      body: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'E-posta',
              labelStyle: TextStyle(color: Colors.white), // E-posta etiket rengi olarak beyaz kullanıldı
            ),
          ),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Ad',
              labelStyle: TextStyle(color: Colors.white), // Ad etiket rengi olarak beyaz kullanıldı
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Şifre',
              labelStyle: TextStyle(color: Colors.white), // Şifre etiket rengi olarak beyaz kullanıldı
            ),
          ),
          ElevatedButton(
            onPressed: () => addData(),
            child: Text('Veri Ekle'),
            style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey.shade900, // Veri Ekle düğmesi rengi olarak mavi kullanıldı
              onPrimary: Colors.white,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('users').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Veriler yükleniyor...');
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['name']),
                      subtitle: Text(data['email']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteData(document.id),
                      ),
                      onTap: () => showUpdateDialog(document.id, data),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addData() async {
    try {
      await _firestore.collection('users').add({
        'email': _emailController.text,
        'name': _nameController.text,
        'password': _passwordController.text,
      });
      _emailController.clear();
      _nameController.clear();
      _passwordController.clear();
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Veri başarıyla eklendi.'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Veri eklenirken bir hata oluştu: $e'),
      ));
    }
  }

  Future<void> deleteData(String documentID) async {
    try {
      await _firestore.collection('users').doc(documentID).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Veri başarıyla silindi.'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Veri silinirken bir hata oluştu: $e'),
      ));
    }
  }

  Future<void> updateData(String documentID, Map<String, dynamic> newData) async {
    try {
      await _firestore.collection('users').doc(documentID).update(newData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Veri başarıyla güncellendi.'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Veri güncellenirken bir hata oluştu: $e'),
      ));
    }
  }

  Future<void> showUpdateDialog(String documentID, Map<String, dynamic> data) async {
    TextEditingController updatedNameController = TextEditingController(text: data['name']);
    TextEditingController updatedPasswordController = TextEditingController(text: data['password']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Veri Güncelle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: updatedNameController,
                decoration: InputDecoration(labelText: 'Ad'),
              ),
              TextField(
                controller: updatedPasswordController,
                decoration: InputDecoration(labelText: 'Şifre'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> updatedData = {
                  'name': updatedNameController.text,
                  'password': updatedPasswordController.text,
                };
                updateData(documentID, updatedData);
                Navigator.pop(context);
              },
              child: Text('Güncelle'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey.shade900, // Güncelle düğmesi rengi olarak mavi kullanıldı
                onPrimary: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('İptal'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // İptal düğmesi rengi olarak kırmızı kullanıldı
                onPrimary: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
