unit UvalidadorUsuario;

interface

uses
  Uusuario, System.SysUtils;

type TValidadorUsuario = class
  private

  protected

  public
  class procedure Validar(PUsuario : TUsuario; PSenhaConfirmacao : String);
end;

implementation

{ TValidadorUsuario }

class procedure TValidadorUsuario.Validar(PUsuario: TUsuario; PSenhaConfirmacao : String);
begin
  if (PUsuario.login.isEmpty) then
  begin
    raise Exception.Create('O campo login n�o pode ser vazio');
  end;

  if (PUsuario.senha.IsEmpty) then
  begin
    raise Exception.Create('O campo senha n�o pode ser vazio');
  end;

  if (PUsuario.senha <> PSenhaConfirmacao) then
  begin
    raise Exception.Create('A senha e a confirma��o devem ser iguais');
  end;


end;

end.
