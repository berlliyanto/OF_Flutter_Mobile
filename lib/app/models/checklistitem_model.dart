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
      checklistId: json['checklist_id'] is String
          ? int.tryParse(json['checklist_id'])
          : json['checklist_id'] ?? 0,
      bodyDepan: json['body_depan'] is String
          ? int.tryParse(json['body_depan'])
          : json['body_depan'] ?? 0,
      bodyBelakang: json['body_belakang'] is String
          ? int.tryParse(json['body_belakang'])
          : json['body_belakang'] ?? 0,
      bodyKanan: json['body_kanan'] is String
          ? int.tryParse(json['body_kanan'])
          : json['body_kanan'] ?? 0,
      bodyKiri: json['body_kiri'] is String
          ? int.tryParse(json['body_kiri'])
          : json['body_kiri'] ?? 0,
      cameraDepan: json['camera_depan'] is String
          ? int.tryParse(json['camera_depan'])
          : json['camera_depan'] ?? 0,
      monitorLayar: json['monitor_layar'] is String
          ? int.tryParse(json['monitor_layar'])
          : json['monitor_layar'] ?? 0,
      lampuUtama: json['lampu_utama'] is String
          ? int.tryParse(json['lampu_utama'])
          : json['lampu_utama'] ?? 0,
      lampuSign: json['lampu_sign'] is String
          ? int.tryParse(json['lampu_sign'])
          : json['lampu_sign'] ?? 0,
      lampuRotary: json['lampu_rotary'] is String
          ? int.tryParse(json['lampu_rotary'])
          : json['lampu_rotary'] ?? 0,
      blueSpotLight: json['blue_spot_light'] is String
          ? int.tryParse(json['blue_spot_light'])
          : json['blue_spot_light'] ?? 0,
      redLineLight: json['red_line_light'] is String
          ? int.tryParse(json['red_line_light'])
          : json['red_line_light'] ?? 0,
      klakson: json['klakson'] is String
          ? int.tryParse(json['klakson'])
          : json['klakson'] ?? 0,
      tapKartu: json['tap_kartu'] is String
          ? int.tryParse(json['tap_kartu'])
          : json['tap_kartu'] ?? 0,
      seatBelt: json['seat_belt'] is String
          ? int.tryParse(json['seat_belt'])
          : json['seat_belt'] ?? 0,
      sirineMundur: json['sirine_mundur'] is String
          ? int.tryParse(json['sirine_mundur'])
          : json['sirine_mundur'] ?? 0,
      kondisiApar: json['kondisi_apar'] is String
          ? int.tryParse(json['kondisi_apar'])
          : json['kondisi_apar'] ?? 0,
      kondisiBanVelg: json['kondisi_ban_velg'] is String
          ? int.tryParse(json['kondisi_ban_velg'])
          : json['kondisi_ban_velg'] ?? 0,
      kotakP3K: json['kotak_p3k'] is String
          ? int.tryParse(json['kotak_p3k'])
          : json['kotak_p3k'] ?? 0,
      fungsiSteering: json['fungsi_steering'] is String
          ? int.tryParse(json['fungsi_steering'])
          : json['fungsi_steering'] ?? 0,
      fungsiHidrolik: json['fungsi_hidrolik'] is String
          ? int.tryParse(json['fungsi_hidrolik'])
          : json['fungsi_hidrolik'] ?? 0,
      fungsiKontrolPanel: json['fungsi_kontrol_panel'] is String
          ? int.tryParse(json['fungsi_kontrol_panel'])
          : json['fungsi_kontrol_panel'] ?? 0,
      dashboard: json['dashboard'] is String
          ? int.tryParse(json['dashboard'])
          : json['dashboard'] ?? 0,
      kebersihanUnit: json['kebersihan_unit'] is String
          ? int.tryParse(json['kebersihan_unit'])
          : json['kebersihan_unit'] ?? 0,
      socketCharger: json['socket_charger'] is String
          ? int.tryParse(json['socket_charger'])
          : json['socket_charger'] ?? 0,
      selangHose: json['selang_hose'] is String
          ? int.tryParse(json['selang_hose'])
          : json['selang_hose'] ?? 0,
      fungsiPengereman: json['fungsi_pengereman'] is String
          ? int.tryParse(json['fungsi_pengereman'])
          : json['fungsi_pengereman'] ?? 0,
      pedalGas: json['pedal_gas'] is String
          ? int.tryParse(json['pedal_gas'])
          : json['pedal_gas'] ?? 0,
      jokKursi: json['jok_kursi'] is String
          ? int.tryParse(json['jok_kursi'])
          : json['jok_kursi'] ?? 0,
      rantai: json['rantai'] is String
          ? int.tryParse(json['rantai'])
          : json['rantai'] ?? 0,
      backRest: json['back_rest'] is String
          ? int.tryParse(json['back_rest'])
          : json['back_rest'] ?? 0,
      fork: json['fork'] is String
          ? int.tryParse(json['fork'])
          : json['fork'] ?? 0,
      safetySensorFork: json['safety_sensor_fork'] is String
          ? int.tryParse(json['safety_sensor_fork'])
          : json['safety_sensor_fork'] ?? 0,
      safetySensorRfid: json['safety_sensor_rfid'] is String
          ? int.tryParse(json['safety_sensor_rfid'])
          : json['safety_sensor_rfid'] ?? 0,
      safetyKartuAkses: json['safety_kartu_akses'] is String
          ? int.tryParse(json['safety_kartu_akses'])
          : json['safety_kartu_akses'] ?? 0,
      safetyTombolBattery: json['safety_tombol_battery'] is String
          ? int.tryParse(json['safety_tombol_battery'])
          : json['safety_tombol_battery'] ?? 0,
      safetyTombolEmergency: json['safety_tombol_emergency'] is String
          ? int.tryParse(json['safety_tombol_emergency'])
          : json['safety_tombol_emergency'] ?? 0,
      safetyPenutupCharger: json['safety_penutup_charger'] is String
          ? int.tryParse(json['safety_penutup_charger'])
          : json['safety_penutup_charger'] ?? 0,
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['checklist_id'] = checklistId;
    data['body_depan'] = bodyDepan;
    data['body_belakang'] = bodyBelakang;
    data['body_kanan'] = bodyKanan;
    data['body_kiri'] = bodyKiri;
    data['camera_depan'] = cameraDepan;
    data['monitor_layar'] = monitorLayar;
    data['lampu_utama'] = lampuUtama;
    data['lampu_sign'] = lampuSign;
    data['lampu_rotary'] = lampuRotary;
    data['blue_spot_light'] = blueSpotLight;
    data['red_line_light'] = redLineLight;
    data['klakson'] = klakson;
    data['tap_kartu'] = tapKartu;
    data['seat_belt'] = seatBelt;
    data['sirine_mundur'] = sirineMundur;
    data['kondisi_apar'] = kondisiApar;
    data['kondisi_ban_velg'] = kondisiBanVelg;
    data['kotak_p3k'] = kotakP3K;
    data['fungsi_steering'] = fungsiSteering;
    data['fungsi_hidrolik'] = fungsiHidrolik;
    data['fungsi_kontrol_panel'] = fungsiKontrolPanel;
    data['dashboard'] = dashboard;
    data['kebersihan_unit'] = kebersihanUnit;
    data['socket_charger'] = socketCharger;
    data['selang_hose'] = selangHose;
    data['fungsi_pengereman'] = fungsiPengereman;
    data['pedal_gas'] = pedalGas;
    data['jok_kursi'] = jokKursi;
    data['rantai'] = rantai;
    data['back_rest'] = backRest;
    data['fork'] = fork;
    data['safety_sensor_fork'] = safetySensorFork;
    data['safety_sensor_rfid'] = safetySensorRfid;
    data['safety_kartu_akses'] = safetyKartuAkses;
    data['safety_tombol_battery'] = safetyTombolBattery;
    data['safety_tombol_emergency'] = safetyTombolEmergency;
    data['safety_penutup_charger'] = safetyPenutupCharger;
    return data;
  }
}
