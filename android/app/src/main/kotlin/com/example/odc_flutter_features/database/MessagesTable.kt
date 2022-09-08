package com.example.odc_flutter_features.database

import androidx.room.*
import kotlinx.coroutines.flow.Flow

@Entity(tableName = "tb_messages")
data class MessagesTable(
    @PrimaryKey(autoGenerate = true) var id: Int = 0,
    var type: String? = null,
    var status: Int=0,
    var content: String? = null,
)

@Dao
interface MessagesDao {
    @Query("SELECT * FROM `tb_messages`")
    fun getAll(): Flow<List<MessagesTable>>

    @Query("SELECT * FROM `tb_messages` where id=:id")
    fun getByID(id:Int): Flow<MessagesTable>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(data: MessagesTable):Long

    @Update
    fun update(data: MessagesTable)

    @Delete
    fun delete(data: MessagesTable)

}
