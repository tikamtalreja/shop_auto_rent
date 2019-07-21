class Note {

	int _id;
	String _title;
	String _description;
	String _date;
	String _rent;

	Note(this._title, this._date, this._rent, [this._description]);

	Note.withId(this._id, this._title, this._date, this._rent, [this._description]);

	int get id => _id;

	String get title => _title;

	String get description => _description;

	String get rent => _rent;

	String get date => _date;

	set title(String newTitle) {
			this._title = newTitle;
		
	}

	set description(String newDescription) {
		if (newDescription.length <= 255) {
			this._description = newDescription;
		}
	}

	set rent(String newRent) {
		
			this._rent = newRent;
		
	}

	set date(String newDate) {
		this._date = newDate;
	}

	// Convert a Note object into a Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['title'] = _title;
		map['description'] = _description;
		map['rent'] = _rent;
		map['date'] = _date;

		return map;
	}

	// Extract a Note object from a Map object
	Note.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._title = map['title'];
		this._description = map['description'];
		this._rent = map['rent'];
		this._date = map['date'];
	}
}




