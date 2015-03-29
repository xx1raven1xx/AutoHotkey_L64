return
/*
Autohor TAKE Takashi
URL     https://github.com/take-takashi

Change log
2012/06/22 fix all
2012/06/19 new
*/

;*** Mixin(objs*) ***;
/*
obj1, obj2, obj3 ... objn
と与えられたとき、
objnからobj1に向かって順にMixinしていく。
つまり、obj1が一番優先度が高い。
*/
Mixin(objs*){
	_newObj := Object()
	
	_maxIndex := objs._MaxIndex()
	Loop, % _maxIndex
	{
		_index := _maxIndex - A_Index + 1
		_obj := objs[_index]
		Mixin_mix(_newObj, _obj)
	}
	
	return _newObj
}

;*** Mixin_mix(newObj, mixObj) ***;
Mixin_mix(newObj, mixObj){
	; member
	_enum := mixObj._NewEnum()
	While _enum[key, value]
	{
		newObj[key] := value
	}
	; base
	_base := mixObj.base
	if(IsObject(_base)){
		if(!IsObject(newObj.base)){
			newObj.base := Object()
		}
		_enum := _base._NewEnum()
		While _enum[key, value]
		{
			newObj.base[key] := value
		}
	}
}