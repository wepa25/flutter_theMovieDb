

DateTime? movieDateParser(String? releaseDate){
if(releaseDate == null || releaseDate.isEmpty) return null;
return DateTime.tryParse(releaseDate);
}