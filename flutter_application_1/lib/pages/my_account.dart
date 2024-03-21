class MyAccount {
  String? tktStatus;
 
  MyAccount(
      {
      this.tktStatus,
     });

  MyAccount.fromJson(Map<String, dynamic> json) {
    
    tktStatus = json['tkt_status'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   
    data['tkt_status'] = this.tktStatus;
    
    return data;
  }
}