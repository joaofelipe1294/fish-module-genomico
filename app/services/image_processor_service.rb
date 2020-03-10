class ImageProcessorService

  def initialize params
    @image = params[:image]
  end

  def call
    image_file = ActiveStorage::Blob.service.path_for(@image.key)
    p image_file
    # TODO: continuar daqui, enviar imagem para processamento e recuperar informacoes
  end

end
