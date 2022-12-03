unit UresourceUtils;

interface

type
  TResourceUtils = class(TObject)
  private

  protected

  public
   class procedure criarDiretorio();
   class function RetornarCaminhoIni() : String;
   class function carregarArquivoResource(PNomeArquivo: String;
      PNomeAplicacao: String): String; //metodo estatico
  end;

implementation

uses
  System.IOUtils, System.Classes, System.SysUtils;

{ TResourceUtils }

class function TResourceUtils.carregarArquivoResource(PNomeArquivo,
  PNomeAplicacao: String): String;
var
  LConteudoArquivo: TStringList;
  LCaminhoPastaAplicacao: String;
  LCaminhoArquivo: String;
  LConteudoTexto : String;
begin
  LConteudoArquivo := TStringList.Create();
  LConteudoTexto := '';
  try
    try
      LCaminhoPastaAplicacao := TPath.Combine(TPath.GetDocumentsPath, PNomeAplicacao);
      LCaminhoArquivo := TPath.Combine(LCaminhoPastaAplicacao, PNomeArquivo);

      LConteudoArquivo.LoadFromFile(LCaminhoArquivo);
      LConteudoTexto := LConteudoArquivo.Text;
    except
      on E: Exception do
        raise Exception.Create('Erro ao carregar os arquivos de resource.' + 'Arquivos: '+ PNomeArquivo);
    end;

  finally
    LConteudoArquivo.Free;
  end;

   Result := LConteudoTexto;
end;

class procedure TResourceUtils.criarDiretorio;
var
  LNomePasta : String;
  LCaminhoPastaAplicacao: String;
begin
  LNomePasta := 'Ravin_sources';
  LCaminhoPastaAplicacao := TPath.Combine(TPath.GetDocumentsPath, LNomePasta);
  ForceDirectories(LCaminhoPastaAplicacao);
end;

class function TResourceUtils.RetornarCaminhoIni: String;
var
  LNomePasta : String;
  LIni       : String;
  LCaminhoPastaAplicacao: String;
begin
  LNomePasta := 'Ravin_sources';
  LCaminhoPastaAplicacao := TPath.Combine(TPath.GetDocumentsPath, LNomePasta);
  LIni := 'configuracoes.ini';
  result := TPath.Combine(LCaminhoPastaAplicacao, LIni);;
end;

end.
