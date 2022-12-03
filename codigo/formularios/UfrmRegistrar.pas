unit UfrmRegistrar;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  UfrmBotaoPrimario,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  System.Actions, Vcl.ActnList, FireDAC.Phys.MySQLWrapper, Vcl.ExtActns,
  Vcl.Mask, Upessoa;

type
  TfrmRegistrar = class(TForm)
    imgFundo: TImage;
    pnlRegistrar: TPanel;
    lblTituloRegistrar: TLabel;
    lblSubTituloRegistrar: TLabel;
    lblTituloAutenticar: TLabel;
    lblSubTituloAutenticar: TLabel;
    edtNome: TEdit;
    edtLogin: TEdit;
    edtSenha: TEdit;
    edtConfirmarSenha: TEdit;
    frmBotaoPrimario1: TfrmBotaoPrimario;
    medtCPF: TMaskEdit;
    procedure lblSubTituloAutenticarClick(Sender: TObject);
    procedure frmBotaoPrimario1spbBotaoPrimarioClick(Sender: TObject);
  private
    { Private declarations }
    procedure RegistrarUsuario();
    function RegistrarPessoaUsuario() : TPessoa;
    procedure ExibirFormLogin();
  public
    { Public declarations }
  end;

var
  frmRegistrar: TfrmRegistrar;

implementation

uses
  UusuarioDao,
  Uusuario, UfrmLogin, UvalidadorUsuario, UformsUtils, UpessoaDao,
  UvalidadorPessoa;

{$R *.dfm}

procedure TfrmRegistrar.ExibirFormLogin;
begin
   TFormsUtils.ShowFormPrincipal(frmLogin, TfrmLogin);
   Close();
end;

procedure TfrmRegistrar.frmBotaoPrimario1spbBotaoPrimarioClick(Sender: TObject);
begin
  Self.RegistrarUsuario;
end;

procedure TfrmRegistrar.lblSubTituloAutenticarClick(Sender: TObject);
begin
  Self.ExibirFormLogin;
end;

function TfrmRegistrar.RegistrarPessoaUsuario : TPessoa;
var
  LPessoa: TPessoa;
  LDaoPessoa: TPessoaDAO;
begin
  try
    try
      LPessoa := TPessoa.Create();
      LDaoPessoa := TPessoaDAO.Create();
      with LPessoa do
      begin
        nome := edtNome.Text;        //em fase de teste
        tipoPessoa := 'F';
        cpf := medtCPF.Text;
        telefone := 11111111;
        dataNascimento := now();
        email := 'teste@teste.com';
        ativo := true;
        criadoEm := Now();
        criadoPor := 'admin';
        alteradoEm := Now();
        alteradoPor := 'admin';
      end;

      TValidadorPessoa.Validar(LPessoa);
      LDaoPessoa := TPessoaDAO.Create();
      LDaoPessoa.InserirPessoa(LPessoa);

    except
      on E: EMySQLNativeException do
      begin
        ShowMessage('Erro ao inserir a pessoa no banco');
      end;
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    if Assigned(LDaoPessoa) then
    begin
      FreeAndNil(LDaoPessoa);
    end;
    Result := LPessoa;
  end;
end;

procedure TfrmRegistrar.RegistrarUsuario;
var
  LUsuario: TUsuario;
  LPessoa : TPessoa;
  LDao: TUsuarioDAO;
  LDaoPessoa: TPessoaDAO;
begin
  try
    try
      LPessoa := RegistrarPessoaUsuario;
      if not(LPessoa.nome.IsEmpty) then
      begin
      LUsuario := TUsuario.Create();
      LDaoPessoa := TPessoaDAO.Create();
      with LUsuario do
      begin
        login := edtLogin.Text;
        senha := edtSenha.Text;
        pessoaId := LDaoPessoa.BuscarIdPessoaMaisRecente;
        criadoEm := Now();
        criadoPor := 'admin';
        alteradoEm := Now();
        alteradoPor := 'admin';
      end;

      TValidadorUsuario.Validar(LUsuario, edtConfirmarSenha.Text);
      LDao := TUsuarioDAO.Create();
      LDao.InserirUsuario(LUsuario);

    if Assigned(LUsuario) then
    begin
      ShowMessage('Cadastro efetuado com sucesso!');
      ShowMessage('Logue no sistema para prosseguir!');
      Self.ExibirFormLogin;
    end;
      end;
    except
      on E: EMySQLNativeException do
      begin
        ShowMessage('Erro ao inserir o usuario no banco');
      end;
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    if Assigned(LDao) then
    begin
      FreeAndNil(LDao);
    end;
    if Assigned(LDaoPessoa) then
    begin
      FreeAndNil(LDaoPessoa);
    end;
    FreeAndNil(LUsuario);
    FreeAndNil(LPessoa);
  end;
end;

end.
