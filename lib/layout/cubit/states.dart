abstract class LayoutStates {}

class InitialLayout extends LayoutStates {}

class ErrorLayout extends LayoutStates {
  final String error;
  ErrorLayout({required this.error});
}

class LoadingLayout extends LayoutStates {}

class SucessLayout extends LayoutStates {}

class ChangeBottomNavigator extends LayoutStates {}

class PostState extends LayoutStates {}

class ProfileImageSucess extends LayoutStates {}

class ProfileImageError extends LayoutStates {}

class CoverImageSucess extends LayoutStates {}

class CoverImageError extends LayoutStates {}

class ProfileUrlSuccess extends LayoutStates {}

class ProfileUrlError extends LayoutStates {}

class ProfilePutError extends LayoutStates {}

class CovereUrlSuccess extends LayoutStates {}

class CovereUrlError extends LayoutStates {}

class CoverePutError extends LayoutStates {}

class UpdateError extends LayoutStates {}

class LoadingUpdate extends LayoutStates {}

class UploadCoverLoading extends LayoutStates {}

class UploadProfileLoading extends LayoutStates {}

class PostImageSucess extends LayoutStates {}

class PostImageError extends LayoutStates {}

class CommentImageSucess extends LayoutStates {}

class CommentImageError extends LayoutStates {}

class UploadpostImageLoading extends LayoutStates {}

class CreatepostLoading extends LayoutStates {}

class CreatepostSucess extends LayoutStates {}

class CreatepostError extends LayoutStates {}

class RemovePostImageSucess extends LayoutStates {}

class GetPostsLoading extends LayoutStates {}

class GetPostsSuccess extends LayoutStates {}

class GetPostsError extends LayoutStates {}

class LikesPostsSuccess extends LayoutStates {}

class LikesPostsError extends LayoutStates {}

class GetUsersChatsSuccess extends LayoutStates {}

class GetUsersChatsError extends LayoutStates {}

class RemoveCommentImageSucess extends LayoutStates {}

class CreateCommentSucess extends LayoutStates {}

class CreateCommentError extends LayoutStates {}

class CreateCommentLoading extends LayoutStates {}

class UploadCommentImageLoading extends LayoutStates {}

class GetCommentsLoading extends LayoutStates {}

class GetCommentsSuccess extends LayoutStates {}

class GetCommentsError extends LayoutStates {}

class SendChatSuccess extends LayoutStates {}

class SendChatError extends LayoutStates {}

class GetChatData extends LayoutStates {}

class ChatImageSucess extends LayoutStates {}

class ChatImageError extends LayoutStates {}

class ChatImageRemoveState extends LayoutStates {}

class UploadChatImageSuccess extends LayoutStates {}

class UploadChatImageError extends LayoutStates {}

class UploadChatImageLoading extends LayoutStates {}
