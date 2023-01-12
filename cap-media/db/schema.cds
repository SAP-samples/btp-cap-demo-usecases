namespace cap.media.db;

using {cuid} from '@sap/cds/common';

entity MediaFiles : cuid {
    @Core.MediaType   : type
    content : LargeBinary;
    @Core.IsMediaType : true
    type    : String;
    filename: String;
}