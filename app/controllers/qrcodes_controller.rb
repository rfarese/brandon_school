class QrcodesController < ApplicationController
  def scan
  end

  def replace
    room = Room.find_by(qrcode_identifier: qrcode_params[:identifier])
    if QrcodeReplacer.new(room).replace
      flash[:notice] = "QR Code was replaced."
    else
      flash[:notice] = "QR Code was not replaced."
    end

    redirect_to rooms_path
  end

private
  def qrcode_params
    params.require(:qrcode).permit(:identifier)
  end
end
