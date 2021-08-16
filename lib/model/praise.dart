class Praise{
  //头像地址
  final String headUrl;
  //昵称
  final String nick;
  //性别
  final String gender;
  //年龄
  final int age;
  //身高
  final int height;
  //点赞数
  final int praiseCount;
  //点赞头像集合
  final List<String> praiseHeads;
  //轮播视频或
  final List<VideoImg> videos;
  //动态内容
  final String content;
  //是否已经点赞
  final bool isLike;

  Praise(this.headUrl, this.nick, this.gender, this.age, this.height, this.praiseCount,this.praiseHeads,  this.videos, this.content, this.isLike);

}
class VideoImg{
  //0 视频 1 图片
  final int type;
  //内容地址
  final String contentUrl;

  VideoImg(this.type, this.contentUrl);

}
