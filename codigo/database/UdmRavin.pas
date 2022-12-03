unit UdmRavin;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs;

type
  TdmRavin = class(TDataModule)
    cnxBancoDeDados: TFDConnection;
    drvBancoDeDados: TFDPhysMySQLDriverLink;
    wtcBancoDeDados: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnxBancoDeDadosBeforeConnect(Sender: TObject);
    procedure cnxBancoDeDadosAfterConnect(Sender: TObject);
  private
    { Private declarations }
    procedure ConfigurarIni();
    procedure CriarTabelas();
    procedure InserirDados();
  public
    { Public declarations }
  end;

var
  dmRavin: TdmRavin;

implementation

uses
  UresourceUtils, UiniUtils, System.IOUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdmRavin.cnxBancoDeDadosAfterConnect(Sender: TObject);
var
  LCriarBaseDados: Boolean;
  LCaminhoBaseDados : String;
begin
  LCaminhoBaseDados := TIniUtils.lerPropriedade(TSECAO.DIRETORIOS, TPROPRIEDADE.DIRETORIO_BANCO);
  LCriarBaseDados := not DirectoryExists(LCaminhoBaseDados);

    if (LCriarBaseDados) then
  begin
    CriarTabelas;
    InserirDados;
  end;
end;

procedure TdmRavin.cnxBancoDeDadosBeforeConnect(Sender: TObject);
var
  LCriarBaseDados: Boolean;
begin
  drvBancoDeDados.VendorLib :=  TIniUtils.lerPropriedade(TSECAO.DIRETORIOS, TPROPRIEDADE.LIB);
  LCriarBaseDados := not DirectoryExists(TIniUtils.lerPropriedade(TSECAO.DIRETORIOS, TPROPRIEDADE.DIRETORIO_BANCO));
  with cnxBancoDeDados do
  begin
//  Params.Values['Server'] := 'localhost';
//    Params.Values['User_Name'] := 'root';
//    Params.Values['Password'] := 'root';
//    Params.Values['DriverID'] := 'MySQL';
//    Params.Values['Port'] := '3306';
    Params.Values['Server'] := TIniUtils.lerPropriedade(TSECAO.CONFIGURACOES, TPROPRIEDADE.SERVER);
    Params.Values['User_Name'] := TIniUtils.lerPropriedade(TSECAO.CONFIGURACOES, TPROPRIEDADE.USER_NAME);
    Params.Values['Password'] := TIniUtils.lerPropriedade(TSECAO.CONFIGURACOES, TPROPRIEDADE.PASSWORD);
    Params.Values['DriverID'] := TIniUtils.lerPropriedade(TSECAO.CONFIGURACOES, TPROPRIEDADE.DRIVERID);
    Params.Values['Port'] := TIniUtils.lerPropriedade(TSECAO.CONFIGURACOES, TPROPRIEDADE.PORT);

    if not (LCriarBaseDados) then
    begin
      Params.Values['Database'] := TIniUtils.lerPropriedade(TSECAO.CONFIGURACOES, TPROPRIEDADE.NOME_DATABASE);
    end;
  end;
end;

procedure TdmRavin.ConfigurarIni;
var
  LDiretorio : String;
  LCaminhoLib : String;
begin
  LDiretorio := TPath.Combine(TPath.GetDocumentsPath, TIniUtils.Pasta_RAVIN);
  LCaminhoLib := TPath.Combine(LDiretorio, TIniUtils.Path_LIB);

  TIniUtils.gravarPropriedade(TSECAO.CONFIGURACOES, TPROPRIEDADE.NOME_DATABASE, TIniUtils.VALOR_DATABASE);
  TIniUtils.gravarPropriedade(TSECAO.CONFIGURACOES, TPROPRIEDADE.SERVER, TIniUtils.VALOR_SERVER);
  TIniUtils.gravarPropriedade(TSECAO.CONFIGURACOES, TPROPRIEDADE.USER_NAME, TIniUtils.VALOR_USER_NAME);
  TIniUtils.gravarPropriedade(TSECAO.CONFIGURACOES, TPROPRIEDADE.PASSWORD, TIniUtils.VALOR_PASSWORD);
  TIniUtils.gravarPropriedade(TSECAO.CONFIGURACOES, TPROPRIEDADE.DRIVERID, TIniUtils.VALOR_DRIVER_ID);
  TIniUtils.gravarPropriedade(TSECAO.CONFIGURACOES, TPROPRIEDADE.PORT, TIniUtils.VALOR_PORT);

  TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.ULTIMO_ACESSO, DateToStr(TIniUtils.Data_Defult));

  TIniUtils.gravarPropriedade(TSECAO.DIRETORIOS, TPROPRIEDADE.DIRETORIO_BANCO, TIniUtils.DIRETORIO_BANCO);
  TIniUtils.gravarPropriedade(TSECAO.DIRETORIOS, TPROPRIEDADE.RAVIN_SOURCES, TIniUtils.Pasta_RAVIN);
  TIniUtils.gravarPropriedade(TSECAO.DIRETORIOS, TPROPRIEDADE.CREATE_SQL, TIniUtils.Path_CREATE_SQL);
  TIniUtils.gravarPropriedade(TSECAO.DIRETORIOS, TPROPRIEDADE.INSERTS_SQL, TIniUtils.Path_INSERTS_SQL);
  TIniUtils.gravarPropriedade(TSECAO.DIRETORIOS, TPROPRIEDADE.LIB, LCaminhoLib);
end;

procedure TdmRavin.CriarTabelas;
begin
  try
    cnxBancoDeDados.ExecSQL(TResourceUtils.carregarArquivoResource(TIniUtils.lerPropriedade(TSECAO.DIRETORIOS, TPROPRIEDADE.CREATE_SQL), TIniUtils.lerPropriedade(TSECAO.DIRETORIOS, TPROPRIEDADE.RAVIN_SOURCES)));
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TdmRavin.DataModuleCreate(Sender: TObject);
var
  LCriarIni : Boolean;
  LCaminhoIni : String;
begin
  LCaminhoIni := TResourceUtils.RetornarCaminhoIni;
  LCriarIni := not FileExists(LCaminhoIni);
  if (LCriarIni) then
  begin
    ConfigurarIni;
  end;
  if not (cnxBancoDeDados.Connected) then
  begin
    cnxBancoDeDados.Connected := true;
  end;
end;

procedure TdmRavin.InserirDados;
begin
  try
    cnxBancoDeDados.StartTransaction();
    cnxBancoDeDados.ExecSQL(TResourceUtils.carregarArquivoResource(TIniUtils.lerPropriedade(TSECAO.DIRETORIOS, TPROPRIEDADE.INSERTS_SQL), TIniUtils.lerPropriedade(TSECAO.DIRETORIOS, TPROPRIEDADE.RAVIN_SOURCES)));
    cnxBancoDeDados.Commit();
  except
    on E: Exception do
    begin
      cnxBancoDeDados.Rollback();
      ShowMessage(e.Message);
    end;
  end;

end;

end.
