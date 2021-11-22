enum ContentType { video, image, unknown }

class ContentTypeUtil {
  static ContentType fromString(String? text) {
    switch (text) {
      case 'video':
        return ContentType.video;
      case 'image':
        return ContentType.image;
      default:
        return ContentType.unknown;
    }
  }

  static ContentType getContentType(String file) {
    if (file.endsWith("mp4") || file.endsWith("mov")) {
      return ContentType.video;
    } else if (file.endsWith("jpg") || file.endsWith("jpeg") || file.endsWith("png") || file.endsWith("gif")) {
      return ContentType.image;
    } else {
      return ContentType.unknown;
    }
  }
}
