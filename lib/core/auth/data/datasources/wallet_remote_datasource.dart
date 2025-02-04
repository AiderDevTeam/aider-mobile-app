import 'package:aider_mobile_app/core/auth/domain/models/wallet/wallet_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class WalletRemoteDatasource {
  Future<WalletModel> createWallet(WalletModel walletModel);
  Future<void> updateWallet(WalletModel walletModel);
  Future<void> deleteWallet(String walletId);
  Future<WalletModel> getWallet(String walletId);
  Future<List<WalletModel>> getWallets();
  Future<void> swapDefaultWallet(
      String newDefaultWalletId, String oldDefaultWalletId);
}

class WalletRemoteDatasourceImpl implements WalletRemoteDatasource {
  WalletRemoteDatasourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  }) {
    _walletCollection = firebaseFirestore.collection('wallets');
  }

  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  late CollectionReference _walletCollection;

  @override
  Future<WalletModel> createWallet(WalletModel walletModel) async {
    final user = firebaseAuth.currentUser;
    final newDocRef = _walletCollection.doc(); // Generate new ID

    walletModel = walletModel.copyWith(
      userId: user?.uid,
      uid: newDocRef.id,
    );

    await newDocRef.set(walletModel.toJson());
    return walletModel;
  }

  @override
  Future<void> deleteWallet(String walletId) async {
    return _walletCollection.doc(walletId).delete();
  }

  @override
  Future<WalletModel> getWallet(String walletId) async {
    final result = await _walletCollection.doc(walletId).get();
    return WalletModel.fromJson(result.data() as Map<String, dynamic>);
  }

  @override
  Future<void> updateWallet(WalletModel walletModel) {
    return _walletCollection.doc(walletModel.uid).update(walletModel.toJson());
  }

  @override
  Future<List<WalletModel>> getWallets() async {
    final user = firebaseAuth.currentUser;
    final result =
        await _walletCollection.where('userId', isEqualTo: user?.uid).get();

    if (result.docs.isEmpty) {
      return [];
    }
    return result.docs
        .map((doc) => WalletModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> swapDefaultWallet(
      String newDefaultWalletId, String oldDefaultWalletId) async {
    await _walletCollection
        .doc(oldDefaultWalletId)
        .update({'isDefault': false});

    await _walletCollection.doc(newDefaultWalletId).update({'isDefault': true});
  }
}
