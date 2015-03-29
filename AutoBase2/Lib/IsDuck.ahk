return
/*
Autohor TAKE Takashi
URL     https://github.com/take-takashi

Change log
2012/06/22 new
*/

;*** IsDuck(parent, child) ***;
/*
childがparentのダック・タイピングなのかどうかを確かめる関数
@return 1 child is duck of parent
@return 0 child is not duck of parent
@return 0 parent or child is not Object (本当は-1にでもしたい)
*/
IsDuck(parent, child){
	if(!IsObject(parent) || !IsObject(child)){
		return 0
	}
	_enum := parent._NewEnum()
	While _enum[key, value]
	{
		if(child[key] = ""){
			return 0
		}
		if(IsObject(parent[key])){
			if(IsObject(child[key])){
				if(!IsDuck(parent[key], child[key])){
					return 0
				}
			}else{
				return 0
			}
		}
	}
	; for base
	if(IsObject(parent.base)){
		if(IsObject(child.base)){
			if(!IsDuck(parent.base, child.base)){
				return 0
			}
		}else{
			return 0
		}
	}
	return 1
}