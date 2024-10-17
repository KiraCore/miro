import 'package:equatable/equatable.dart';
import 'package:miro/shared/entity/keyfile/a_keyfile_entity.dart';

class EthereumKeyfileEntity extends AKeyfileEntity {
  final int version;
  final String id;
  final EthereumKeyfileCrypto crypto;

  const EthereumKeyfileEntity({
    required this.version,
    required this.id,
    required this.crypto,
  });

  factory EthereumKeyfileEntity.fromJson(Map<String, dynamic> json) {
    return EthereumKeyfileEntity(
      version: json['version'] as int,
      id: json['id'] as String,
      crypto: EthereumKeyfileCrypto.fromJson(json['crypto'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, Object> toJson() {
    return <String, Object>{
      'version': version,
      'id': id,
      'crypto': crypto.toJson(),
    };
  }

  @override
  List<Object?> get props => <Object?>[version, id, crypto];
}

class EthereumKeyfileCrypto extends Equatable {
  final String ciphertext;
  final EthereumKeyfileCipherParams cipherparams;
  final String cipher;
  final String kdf;
  final EthereumKeyfileKdfParams kdfparams;
  final String mac;

  const EthereumKeyfileCrypto({
    required this.ciphertext,
    required this.cipherparams,
    required this.cipher,
    required this.kdf,
    required this.kdfparams,
    required this.mac,
  });

  Map<String, Object> toJson() {
    return <String, Object>{
      'ciphertext': ciphertext,
      'cipherparams': cipherparams.toJson(),
      'cipher': cipher,
      'kdf': kdf,
      'kdfparams': kdfparams.toJson(),
      'mac': mac,
    };
  }

  factory EthereumKeyfileCrypto.fromJson(Map<String, dynamic> json) {
    return EthereumKeyfileCrypto(
      ciphertext: json['ciphertext'] as String,
      cipherparams: EthereumKeyfileCipherParams.fromJson(json['cipherparams'] as Map<String, dynamic>),
      cipher: json['cipher'] as String,
      kdf: json['kdf'] as String,
      kdfparams: EthereumKeyfileKdfParams.fromJson(json['kdfparams'] as Map<String, dynamic>),
      mac: json['mac'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        ciphertext,
        cipherparams,
        cipher,
        kdf,
        kdfparams,
        mac,
      ];
}

class EthereumKeyfileCipherParams extends Equatable {
  final String iv;

  const EthereumKeyfileCipherParams({required this.iv});

  Map<String, dynamic> toJson() => <String, dynamic>{'iv': iv};

  factory EthereumKeyfileCipherParams.fromJson(Map<String, dynamic> json) {
    return EthereumKeyfileCipherParams(iv: json['iv'] as String);
  }

  @override
  List<Object?> get props => <Object?>[iv];
}

class EthereumKeyfileKdfParams extends Equatable {
  final int dklen;
  final String salt;
  final int c;
  final String prf;

  const EthereumKeyfileKdfParams({
    required this.dklen,
    required this.salt,
    required this.c,
    required this.prf,
  });

  Map<String, Object> toJson() {
    return <String, Object>{
      'dklen': dklen,
      'salt': salt,
      'c': c,
      'prf': prf,
    };
  }

  factory EthereumKeyfileKdfParams.fromJson(Map<String, dynamic> json) {
    return EthereumKeyfileKdfParams(
      dklen: json['dklen'] as int,
      salt: json['salt'] as String,
      c: json['c'] as int,
      prf: json['prf'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[dklen, salt, c, prf];
}
