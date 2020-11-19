unit uTestScore;

interface

uses
  DUnitX.TestFramework,
  uScore;

type
  [TestFixture]
  TTestBoliche = class(TObject)
  private
    class function PontosJogadas(pinos: array of integer; partida: IPartidaBoliche): IPartidaBoliche; static;
  public
    [Test]
    // [Ignore('Comentar o linha Ignore para que o teste rode'))
    procedure PartidaComTudoZerado;
    [Test]
    // [Ignore]
    procedure PartidaSemStrikesSpares;
    [Test]
    // [Ignore]
    procedure FezSpareDepoisZerou;
    [Test]
    // [Ignore]
    procedure FezSpareDobrouProxima;
    [Test]
    // [Ignore]
    procedure CadaSparesConsecutivoRecebeBonusDeUmaJogada;
    [Test]
    // [Ignore]
    procedure UmSpareNoUltimoQuadroRecebeBonusDeUmaJogadaUmaVez;
    [Test]
    [Ignore]
    procedure SpareNoUltimoQuadroDeveSerRoladoAntesQuePontuacaoPossaSerCalculada;
  end;

implementation

class function TTestBoliche.PontosJogadas(pinos: array of integer; partida: IPartidaBoliche): IPartidaBoliche;
var
  count: integer;
begin
  for count in pinos do
    partida.Lista(count);
  result := partida;
end;

procedure TTestBoliche.SpareNoUltimoQuadroDeveSerRoladoAntesQuePontuacaoPossaSerCalculada;
var
  partida: IPartidaBoliche;
begin
  partida := PontosJogadas([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10], NovaPartidaBoliche);
  Assert.AreEqual(-1, partida.Pontuacao);
end;

procedure TTestBoliche.UmSpareNoUltimoQuadroRecebeBonusDeUmaJogadaUmaVez;
var
  partida: IPartidaBoliche;
begin
  partida := PontosJogadas([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7], NovaPartidaBoliche);
  Assert.AreEqual(10, partida.Pontuacao);
end;

procedure TTestBoliche.FezSpareDobrouProxima;
var
  partida: IPartidaBoliche;
begin
  partida := PontosJogadas([6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], NovaPartidaBoliche);
  Assert.AreEqual(16, partida.Pontuacao);
end;

procedure TTestBoliche.CadaSparesConsecutivoRecebeBonusDeUmaJogada;
var
  partida: IPartidaBoliche;
begin
  partida := PontosJogadas([5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], NovaPartidaBoliche);
  Assert.AreEqual(34, partida.Pontuacao);
end;

procedure TTestBoliche.FezSpareDepoisZerou;
var
  partida: IPartidaBoliche;
begin
  partida := PontosJogadas([6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], NovaPartidaBoliche);
  Assert.AreEqual(10, partida.Pontuacao);
end;

procedure TTestBoliche.PartidaComTudoZerado;
var
  partida: IPartidaBoliche;
begin
  partida := PontosJogadas([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], NovaPartidaBoliche);
  Assert.AreEqual(0, partida.Pontuacao);
end;

procedure TTestBoliche.PartidaSemStrikesSpares;
var
  partida: IPartidaBoliche;
begin
  partida := PontosJogadas([3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6], NovaPartidaBoliche);
  Assert.AreEqual(90, partida.Pontuacao);
end;

initialization

TDUnitX.RegisterTestFixture(TTestBoliche);

end.
