unit uScore;

interface

uses
  System.Generics.Collections;

type
  IPartidaBoliche = interface
    procedure Lista(pinos: integer);
    function Pontuacao: integer;
  end;

  TBolicheFrame = class
    FrameIndex: integer;
    PrimeiraBola: integer;
    SegundaBola: integer;
    FezStrike: Boolean;
    FezSpare: Boolean;
    FMinimoIndex: integer;
    FMaximoIndex: integer;
  public
    constructor Create(Index :integer);
  end;

  TPartidaBoliche = class(TInterfacedObject, IPartidaBoliche)
    private
      FPontos: Integer;
      FLista: integer;
      FPinos: TList<integer>;
      FJogadas: TList<TBolicheFrame>;
      FIndex: integer;
    public
      procedure Lista(pinos: integer); //Implementação das interfaces pra facilitar o gerenciamento de memória
      function Pontuacao: integer;
      constructor Create;
  end;

  function NovaPartidaBoliche: IPartidaBoliche;


implementation

function NovaPartidaBoliche: IPartidaBoliche;
begin
  result := TPartidaBoliche.Create;
end;

constructor TBolicheFrame.Create(Index: integer);
begin
  FrameIndex := Index;
  PrimeiraBola := 0;
  SegundaBola := 0;
  FezStrike := False;
  FezSpare := False;
  FMinimoIndex := Index;
  FMaximoIndex := Index;
end;

constructor TPartidaBoliche.Create;
begin
  FPontos := 0;
  FIndex := 0;
  FPinos := TList<integer>.Create;
  FJogadas := TList<TBolicheFrame>.Create;
end;

procedure TPartidaBoliche.Lista(pinos: integer);
begin
  FPinos.Add(pinos);
  inc(FIndex);
  if pinos = 10 then
    inc(FIndex);
end;

function TPartidaBoliche.Pontuacao: integer;
var
  I: Integer;
  pinos: integer;
  FNovaJogada: Boolean;

  iJogada: integer;
  aJogada, tmpJogada: TBolicheFrame;

  pontuacaoAtual: Integer;
begin
  Flista := 0;
  iJogada := 0;
  aJogada := nil;
  FNovaJogada := True;
  for I := 0 to FPinos.Count - 1 do
  begin
    pinos := FPinos[I];
    if FNovaJogada then
    begin
      aJogada := TBolicheFrame.Create(iJogada);
      aJogada.PrimeiraBola := pinos;
      aJogada.FezStrike := (pinos = 10); //Se derrubou todos os pinos
      FNovaJogada := aJogada.FezStrike;
      if aJogada.FezStrike then
      begin
        FJogadas.Add(aJogada);
        aJogada.FMaximoIndex := aJogada.FMinimoIndex + 2;
        inc(iJogada);
      end;
    end
    else
    begin
      aJogada.SegundaBola := pinos;
      if (not aJogada.FezStrike) then
      begin
        aJogada.FezSpare := (aJogada.PrimeiraBola + pinos = 10);
        aJogada.FMaximoIndex := aJogada.FMinimoIndex + 2;
      end;
      FJogadas.Add(aJogada);
      FNovaJogada := True;
      inc(iJogada);
    end;
  end;

  for tmpJogada in FJogadas do
  begin
    pontuacaoAtual := (tmpJogada.PrimeiraBola + tmpJogada.SegundaBola);
    if (pontuacaoAtual >= 0) and (pontuacaoAtual <= 10) then
    begin
      FPontos := FPontos + pontuacaoAtual;
      if tmpJogada.FezStrike and (tmpJogada.FrameIndex < iJogada) and (tmpJogada.FMaximoIndex < iJogada) then
        FPontos := FPontos + FPinos[tmpJogada.FMaximoIndex - 1] + FPinos[tmpJogada.FMaximoIndex];

      if tmpJogada.FezSpare and (tmpJogada.FrameIndex < iJogada) and (tmpJogada.FMaximoIndex < iJogada) then
        FPontos := FPontos + (FPinos[tmpJogada.FMaximoIndex]);
    end
    else
    begin
      FPontos := -1;
      break;
    end;
  end;
  Result := FPontos;
end;

end.
