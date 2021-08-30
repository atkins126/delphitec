unit Controller.Observer.Item;

interface

uses
  Controller.Observer.Interfaces, System.Generics.Collections, System.Sysutils;

type
  TControllerObserverItem = class(TInterfacedObject, ISubjectItem)
    private
      FList : TList<IObserverItem>;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : ISubjectItem;
      function Add(Value : iObserverItem) : ISubjectItem;
      function Notify(Value : TRecordItem) : ISubjectItem;
  end;

implementation

{ TControllerVenda }

constructor TControllerObserverItem.Create;
begin
  FList := TList<IObserverItem>.Create;
end;

destructor TControllerObserverItem.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TControllerObserverItem.Add(Value: iObserverItem): ISubjectItem;
begin
  Result := Self;
  FList.Add(Value);
end;

class function TControllerObserverItem.New : ISubjectItem;
begin
  Result := Self.Create;
end;

function TControllerObserverItem.Notify(Value: TRecordItem): ISubjectItem;
var
  I : Integer;
begin
  Result := Self;
  for I := 0 to Pred(FList.Count) do
      FList[I].UpdateItem(Value);
end;

end.
