using { cap.media.db as db } from '../db/schema';

service MediaService {

    entity MediaFiles as projection on db.MediaFiles;

}
