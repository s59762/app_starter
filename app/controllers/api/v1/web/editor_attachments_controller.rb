class Api::V1::Web::EditorAttachmentsController < Api::V1::Web::BaseController
  before_action :for_admin_only!

  def create
    attachment = EditorAttachment.new
    form = EditorAttachmentForm.new(attachment)

    return raise ValidationFailureException, form unless form.validate(attachment_params)

    form.save

    render json: EditorAttachment.where(id: form.created_attachment_ids)
  end

  def destroy
    attachment = EditorAttachment.find(params[:id])

    attachment.destroy

    render json: { messages: ['attachment deleted successfully.'] }
  end

  private

  def attachment_params
    params.require(:attachment).permit(files: [])
  end
end
