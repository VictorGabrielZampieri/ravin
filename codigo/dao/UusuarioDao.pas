unit UusuarioDao;

interface

uses
  Uusuario, FireDAC.Comp.Client;

type  TUsuarioDAO = class(TObject)
  private

  protected

  public
    procedure InserirUsuario(PUsuario : TUsuario);
    function BuscarUsuarioPorLoginSenha(PLogin : String; PSenha : String): TUsuario;
end;

implementation

{ TUsuarioDAO }

uses UdmRavin, System.SysUtils;

function TUsuarioDAO.BuscarUsuarioPorLoginSenha(PLogin,
  PSenha: String): TUsuario;
var
  LQuery : TFDQuery;
  LUsuario : TUsuario;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'SELECT * FROM usuario WHERE login = :login AND senha = :senha';
  LQuery.ParamByName('login').AsString := PLogin;
  LQuery.ParamByName('senha').AsString := PSenha;
  LQuery.Open();
  LUsuario := nil;

  if not LQuery.IsEmpty then
  begin
   LUsuario := TUsuario.Create();
   LUsuario.id := LQuery.FieldByName('id').AsInteger;
   LUsuario.login := LQuery.FieldByName('login').AsString;
   LUsuario.senha := LQuery.FieldByName('senha').AsString;
   LUsuario.pessoaId := LQuery.FieldByName('pessoaId').AsInteger;
   LUsuario.criadoEm := LQuery.FieldByName('criadoEm').AsDateTime;
   LUsuario.criadoPor := LQuery.FieldByName('criadoPor').AsString;
   LUsuario.alteradoEm := LQuery.FieldByName('alteradoEm').AsDateTime;
   LUsuario.alteradoPor := LQuery.FieldByName('alteradoPor').AsString;
  end;

  LQuery.Close();
  FreeAndNil(LQuery);
  Result := LUsuario;
end;

procedure TUsuarioDAO.InserirUsuario(PUsuario: TUsuario);
var
  LQuery : TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  with LQuery do
  begin
  Connection := dmRavin.cnxBancoDeDados;
  SQL.Add('INSERT INTO usuario ');
  SQL.Add(' (login, senha, pessoaId, criadoEm, criadoPor, alteradoEm, alteradoPor) ');
  SQL.add(' VALUES  (:login, :senha, :pessoaId, :criadoEm, :criadoPor, :alteradoEm, :alteradoPor)');

  ParamByName('login').AsString := PUsuario.login;
  ParamByName('senha').AsString := PUsuario.senha;
  ParamByName('pessoaId').AsInteger := PUsuario.pessoaId;
  ParamByName('criadoEm').AsDateTime := PUsuario.criadoEm;
  ParamByName('criadoPor').AsString := PUsuario.criadoPor;
  ParamByName('alteradoEm').AsDateTime := PUsuario.alteradoEm;
  ParamByName('alteradoPor').AsString := PUsuario.alteradoPor;
  ExecSQL();
  end;

  FreeAndNil(LQuery);
end;

end.
