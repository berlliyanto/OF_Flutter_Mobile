class ChecklistItemModel {
  late int id;
  late int checklistId;
  late int bodyDepan;
  late int bodyBelakang;
  late int bodyKanan;
  late int bodyKiri;
  late int cameraDepan;
  late int monitorLayar;
  late int lampuUtama;
  late int lampuSign;
  late int lampuRotary;
  late int blueSpotLight;
  late int redLineLight;
  late int klakson;
  late int tapKartu;
  late int seatBelt;
  late int sirineMundur;
  late int kondisiApar;
  late int kondisiBanVelg;
  late int kotakP3K;
  late int fungsiSteering;
  late int fungsiHidrolik;
  late int fungsiKontrolPanel;
  late int dashboard;
  late int kebersihanUnit;
  late int socketCharger;
  late int selangHose;
  late int fungsiPengereman;
  late int pedalGas;
  late int jokKursi;
  late int rantai;
  late int backRest;
  late int fork;
  late int safetySensorFork;
  late int safetySensorRfid;
  late int safetyKartuAkses;
  late int safetyTombolBattery;
  late int safetyTombolEmergency;
  late int safetyPenutupCharger;
  late DateTime? createdAt;
  late DateTime? updatedAt;

  ChecklistItemModel({
    required this.id,
    required this.checklistId,
    required this.bodyDepan,
    required this.bodyBelakang,
    required this.bodyKanan,
    required this.bodyKiri,
    required this.cameraDepan,
    required this.monitorLayar,
    required this.lampuUtama,
    required this.lampuSign,
    required this.lampuRotary,
    required this.blueSpotLight,
    required this.redLineLight,
    required this.klakson,
    required this.tapKartu,
    required this.seatBelt,
    required this.sirineMundur,
    required this.kondisiApar,
    required this.kondisiBanVelg,
    required this.kotakP3K,
    required this.fungsiSteering,
    required this.fungsiHidrolik,
    required this.fungsiKontrolPanel,
    required this.dashboard,
    required this.kebersihanUnit,
    required this.socketCharger,
    required this.selangHose,
    required this.fungsiPengereman,
    required this.pedalGas,
    required this.jokKursi,
    required this.rantai,
    required this.backRest,
    required this.fork,
    required this.safetySensorFork,
    required this.safetySensorRfid,
    required this.safetyKartuAkses,
    required this.safetyTombolBattery,
    required this.safetyTombolEmergency,
    required this.safetyPenutupCharger,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChecklistItemModel.fromJson(Map<String, dynamic> json) {
    return ChecklistItemModel(
      id: json['id'],
      checklistId: json['checklist_id'],
      bodyDepan: json['body_depan'],
      bodyBelakang: json['body_belakang'],
      bodyKanan: json['body_kanan'],
      bodyKiri: json['body_kiri'],
      cameraDepan: json['camera_depan'],
      monitorLayar: json['monitor_layar'],
      lampuUtama: json['lampu_utama'],
      lampuSign: json['lampu_sign'],
      lampuRotary: json['lampu_rotary'],
      blueSpotLight: json['blue_spot_light'],
      redLineLight: json['red_line_light'],
      klakson: json['klakson'],
      tapKartu: json['tap_kartu'],
      seatBelt: json['seat_belt'],
      sirineMundur: json['sirine_mundur'],
      kondisiApar: json['kondisi_apar'],
      kondisiBanVelg: json['kondisi_ban_velg'],
      kotakP3K: json['kotak_p3k'],
      fungsiSteering: json['fungsi_steering'],
      fungsiHidrolik: json['fungsi_hidrolik'],
      fungsiKontrolPanel: json['fungsi_kontrol_panel'],
      dashboard: json['dashboard'],
      kebersihanUnit: json['kebersihan_unit'],
      socketCharger: json['socket_charger'],
      selangHose: json['selang_hose'],
      fungsiPengereman: json['fungsi_pengereman'],
      pedalGas: json['pedal_gas'],
      jokKursi: json['jok_kursi'],
      rantai: json['rantai'],
      backRest: json['back_rest'],
      fork: json['fork'],
      safetySensorFork: json['safety_sensor_fork'],
      safetySensorRfid: json['safety_sensor_rfid'],
      safetyKartuAkses: json['safety_kartu_akses'],
      safetyTombolBattery: json['safety_tombol_battery'],
      safetyTombolEmergency: json['safety_tombol_emergency'],
      safetyPenutupCharger: json['safety_penutup_charger'],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }
}
