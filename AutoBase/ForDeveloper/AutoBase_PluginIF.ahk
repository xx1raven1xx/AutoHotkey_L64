/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/
return

;*** AutoBase_PluginIF はDeveloperは気にしなくても良い ***;
/*
今のところ使っていない
*/
class AutoBase_PluginIF{
  static __static__ := Object()
  __local__ := Object()
  
  __New(){
  }
/*
  ; Pluginを読み込む前に一回実行される
  ; 逆にユーザーがinitを実行しようとしても意味がない
  __init(_ModelClass){
    if(__static__.init = ""){
      return
    }
    this.__static__.ModelClass := _ModelClass
  }
  
  __getModelClass(){
    return this.__static__.ModelClass
  }
*/
}

/*
PluginのDeveloperはこのクラスを継承してPluginをつくること
*/
class PluginIF extends AutoBase_PluginIF{
  __local__ := Object()
  __New(){
    this.setNormalList(Array())
    this.setCommandList(Array())
    this.setMenuList(Array())
    AutoBase_PluginIF.__New.(this)
  }
  
  ; this.makeListClass(_icon, _displayText, ...)のような通常の呼び出しでもOK
  ; this.makeListClass({icon: _icon, _displayText: _displayText, ...})のようなオブジェクト形式の呼び出しでもOK
  ; NormalListに加えるつもりなら、
  ; this.addNormalList(_icon, _displayText, ...)
  ; this.addNormalList({icon: _icon, _displayText: _displayText, ...})
  ; という感じに直接NormalListに追加することもできる
  makeListClass(_params*){
    _icon := _displayText := _searchText := _keyPressFunctionName := _dragAndDropFunctionName := _otherParams := ""
    _paramsNum := _params.MaxIndex()
    if(_paramsNum = 0){
      return
    }else if(_paramsNum = 1 && IsExtends(_params[1], AutoBase_ListClass)){
      ; パラメータがListClassだったとき
      return _params[1]
    }else if(_paramsNum = 1 && IsObject(_params[1])){
      ; パラメータが1つのオブジェクトだったときはオブジェクトの中を見てListClassを作成
      ; オブジェクトで指定したいときはここを参照してkey名を指定する
      ; 例）{icon: "", displayText: "test", searchText: ""}
      _icon                    := _params[1].icon
      _displayText             := _params[1].displayText
      _searchText              := _params[1].searchText
      _keyPressFunctionName    := _params[1].keyPressFunctionName
      _dragAndDropFunctionName := _params[1].dragAndDropFunctionName
      _otherParams             := _params[1].otherParams
    }else{
      ; パラメータが通常の引数ならば、それにしたがってListClassを作成
      _icon                    := _params[1]
      _displayText             := _params[2]
      _searchText              := _params[3]
      _keyPressFunctionName    := _params[4]
      _dragAndDropFunctionName := _params[5]
      _otherParams             := _params[6]
    }
    ; パラメータの初期値を決定
    ; 参考演算子
    ; (式) ? 式がTrue : 式がFalse(つまり式が""であり、初期値の設定)
    ; なお、onKeyPress, onDragAndDrop関数は仮実装してあり、
    ; Developerは自由に上書き(オーバーライド)しても良いし、
    ; 自分でkeyPressFunctionNameを自分で定義した別の関数名にしても良い
    _displayText             := (_displayText) ? _displayText : this.__Class
    _searchText              := (_searchText) ? _searchText : _displayText
    _keyPressFunctionName    := (_keyPressFunctionName) ? _keyPressFunctionName : "onKeyPress"
    _dragAndDropFunctionName := (_dragAndDropFunctionName) ? _dragAndDropFunctionName : "onDragAndDrop"
    
    _listClass := new AutoBase_ListClass(this
                                         , _icon
                                         , _displayText
                                         , _searchText
                                         , _keyPressFunctionName
                                         , _dragAndDropFunctionName
                                         , _otherParams)
    return _listClass
  }
  
  addNormalList(_params*){
    _listClass := this.makeListClass(_params*)
    this.addList(this.getNormalList(), _listClass)
  }
  removeNormalList(_firstKey, _lastKey=""){
    this.removeList(this.getNormalList(), _firstKey, _lastKey)
  }
  resetNormalList(){
    this.setNormalList(Array())
  }
  
  addCommandList(_params*){
    _listClass := this.makeListClass(_params*)
    this.addList(this.getCommandList(), _listClass)
  }
  removeCommandList(_firstKey, _lastKey=""){
    this.removeList(this.getCommandList(), _firstKey, _lastKey)
  }
  resetCommandList(){
    this.setCommandList(Array())
  }
  
  addMenuList(){
    _listClass := this.makeListClass(_params*)
    this.addList(this.getMenuList(), _listClass)
  }
  removeMenuList(_firstKey, _lastKey=""){
    this.removeList(this.getMenuList(), _firstKey, _lastKey)
  }
  resetMenuList(){
    this.setMenuList(Array())
  }
  
  addList(_List, _listClass){
    if(IsObject(_List) = 0 ||  _listClass = ""){
      return
    }
    _List.Insert(_listClass)
  }
  
  removeList(_List, _firstKey, _lastKey=""){
    if(!IsObject(_List)){
      return
    }
    if(_lastKey = ""){
      _List.Remove(_firstKey)
    }else{
      _List.Remove(_firstKey, _lastKey)
    }
  }
  
  ; キーの取り出し方は_event.key
  onKeyPress(_ListClass, _event){
    MsgBox % _ListClass.getPlugin().__Class ", key = " _event.key
  }
  
  onDragAndDrop(_ListClass, _event){
    ; 何もしない(うっとおしいから)
  }
  
  getNormalList(){
    return this.__local__.normalList
  }
  setNormalList(_Array){
    if(IsObject(_Array)){
      return this.__local__.normalList
    }
    Throw, % "_Array is not Array(Object)"
  }
  getCommandList(){
    return this.__local__.commandList
  }
  setCommandList(_Array){
    if(IsObject(_Array)){
      return this.__local__.commandList
    }
    Throw, % "_Array is not Array(Object)"
  }
  getMenuList(){
    return this.__local__.menuList
  }
  setMenuList(_Array){
    if(IsObject(_Array)){
      return this.__local__.menuList
    }
    Throw, % "_Array is not Array(Object)"
  }
}