unit Controller.Observer.Interfaces;

interface

type
  TRecordItem = record
    Descricao : String;
    Quantidade : Integer;
    Valor : Currency;

  end;

  IObserverItem = interface
    ['{2498F61F-865D-493F-AA99-3330369012B9}']
    function UpdateItem(Value : TRecordItem) : IObserverItem;
  end;

  ISubjectItem = interface
    ['{72F41A17-8CE2-474E-B9AF-AF1322BC1F1C}']
    function Add(Value : iObserverItem) : ISubjectItem;
    function Notify(Value : TRecordItem) : ISubjectItem;
  end;

implementation

end.
