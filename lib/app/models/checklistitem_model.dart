class ChecklistItemModel {
  late int id;
  late int? checklistId;
  late int? bodyDepan;
  late int? bodyBelakang;
  late int? bodyKanan;
  late int? bodyKiri;
  late int? cameraDepan;
  late int? monitorLayar;
  late int? lampuUtama;
  late int? lampuSign;
  late int? lampuRotary;
  late int? blueSpotLight;
  late int? redLineLight;
  late int? klakson;
  late int? tapKartu;
  late int? seatBelt;
  late int? sirineMundur;
  late int? kondisiApar;
  late int? kondisiBanVelg;
  late int? kotakP3K;
  late int? fungsiSteering;
  late int? fungsiHidrolik;
  late int? fungsiKontrolPanel;
  late int? dashboard;
  late int? kebersihanUnit;
  late int? socketCharger;
  late int? selangHose;
  late int? fungsiPengereman;
  late int? pedalGas;
  late int? jokKursi;
  late int? rantai;
  late int? backRest;
  late int? fork;
  late int? safetySensorFork;
  late int? safetySensorRfid;
  late int? safetyKartuAkses;
  late int? safetyTombolBattery;
  late int? safetyTombolEmergency;
  late int? safetyPenutupCharger;
  late DateTime? createdAt;
  late DateTime? updatedAt;

  ChecklistItemModel({
    required this.id,
    this.checklistId,
    this.bodyDepan,
    this.bodyBelakang,
    this.bodyKanan,
    this.bodyKiri,
    this.cameraDepan,
    this.monitorLayar,
    this.lampuUtama,
    this.lampuSign,
    this.lampuRotary,
    this.blueSpotLight,
    this.redLineLight,
    this.klakson,
    this.tapKartu,
    this.seatBelt,
    this.sirineMundur,
    this.kondisiApar,
    this.kondisiBanVelg,
    this.kotakP3K,
    this.fungsiSteering,
    this.fungsiHidrolik,
    this.fungsiKontrolPanel,
    this.dashboard,
    this.kebersihanUnit,
    this.socketCharger,
    this.selangHose,
    this.fungsiPengereman,
    this.pedalGas,
    this.jokKursi,
    this.rantai,
    this.backRest,
    this.fork,
    this.safetySensorFork,
    this.safetySensorRfid,
    this.safetyKartuAkses,
    this.safetyTombolBattery,
    this.safetyTombolEmergency,
    this.safetyPenutupCharger,
    this.createdAt,
    this.updatedAt,
  });

  factory ChecklistItemModel.fromJson(Map<String, dynamic> json) {
    return ChecklistItemModel(
      id: json['id'],
      checklistId: json['checklist_id'] ?? 0,
      bodyDepan: json['body_depan'] ?? 0,
      bodyBelakang: json['body_belakang'] ?? 0,
      bodyKanan: json['body_kanan'] ?? 0,
      bodyKiri: json['body_kiri'] ?? 0,
      cameraDepan: json['camera_depan'] ?? 0,
      monitorLayar: json['monitor_layar'] ?? 0,
      lampuUtama: json['lampu_utama'] ?? 0,
      lampuSign: json['lampu_sign'] ?? 0,
      lampuRotary: json['lampu_rotary'] ?? 0,
      blueSpotLight: json['blue_spot_light'] ?? 0,
      redLineLight: json['red_line_light'] ?? 0,
      klakson: json['klakson'] ?? 0,
      tapKartu: json['tap_kartu'] ?? 0,
      seatBelt: json['seat_belt'] ?? 0,
      sirineMundur: json['sirine_mundur'] ?? 0,
      kondisiApar: json['kondisi_apar'] ?? 0,
      kondisiBanVelg: json['kondisi_ban_velg'] ?? 0,
      kotakP3K: json['kotak_p3k'] ?? 0,
      fungsiSteering: json['fungsi_steering'] ?? 0,
      fungsiHidrolik: json['fungsi_hidrolik'] ?? 0,
      fungsiKontrolPanel: json['fungsi_kontrol_panel'] ?? 0,
      dashboard: json['dashboard'] ?? 0,
      kebersihanUnit: json['kebersihan_unit'] ?? 0,
      socketCharger: json['socket_charger'] ?? 0,
      selangHose: json['selang_hose'] ?? 0,
      fungsiPengereman: json['fungsi_pengereman'] ?? 0,
      pedalGas: json['pedal_gas'] ?? 0,
      jokKursi: json['jok_kursi'] ?? 0,
      rantai: json['rantai'] ?? 0,
      backRest: json['back_rest'] ?? 0,
      fork: json['fork'] ?? 0,
      safetySensorFork: json['safety_sensor_fork'] ?? 0,
      safetySensorRfid: json['safety_sensor_rfid'] ?? 0,
      safetyKartuAkses: json['safety_kartu_akses'] ?? 0,
      safetyTombolBattery: json['safety_tombol_battery'] ?? 0,
      safetyTombolEmergency: json['safety_tombol_emergency'] ?? 0,
      safetyPenutupCharger: json['safety_penutup_charger'] ?? 0,
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }
}
