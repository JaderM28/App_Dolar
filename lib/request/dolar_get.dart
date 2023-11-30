

class FetchGet {
  String? valor;
  String? unidad;
  String? vigenciaDesde;
  String? vigenciaHasta;

  FetchGet({
    this.valor,
    this.unidad,
    this.vigenciaDesde,
    this.vigenciaHasta,
  });

  FetchGet.fromJson(Map<String, dynamic> json){
    valor  = json['valor'];
    unidad  = json['unidad'];
    vigenciaDesde  = json['vigenciaDesde'];
    vigenciaHasta  = json['vigenciaHasta'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['valor'] = valor;
    data['unidad'] = unidad;
    data['vigenciaDesde'] = vigenciaDesde;
    data['vigenciaHasta'] = vigenciaHasta;

    return data;
  }

  
}