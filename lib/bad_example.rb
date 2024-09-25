require "aws-sdk-s3"

class BadExample
  def initialize(bucket:)
    @bucket = bucket
  end

  def download(object_key)
    client.get_object(bucket: @bucket, key: object_key)
  end

  def upload(file_path, object_key)
    resp = client.put_object(
      {
        body: file_path,
        bucket: ENV["BUCKET_NAME"],
        key: object_key,
      }
    )
    resp
  end

  private

  def client
    @client ||= Aws::S3::Client.new(
      region: "us-east-1",
      endpoint: "http://localhost.localstack.cloud:4566",
      force_path_style: true,
    )
  end
end
