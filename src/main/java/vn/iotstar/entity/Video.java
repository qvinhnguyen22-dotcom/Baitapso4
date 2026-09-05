package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "videos")
@NamedQuery(name = "Video.findAll", query = "SELECT v FROM Video v")
public class Video implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "VideoId")
    private String videoId;

    @Column(name = "Title", columnDefinition = "nvarchar(255) null")
    private String title;

    @Column(name = "Poster", columnDefinition = "nvarchar(255) null")
    private String poster;

    @Column(name = "Description", columnDefinition = "nvarchar(MAX) null")
    private String description;

    @Column(name = "Views")
    private int views;

    @Column(name = "Active")
    private int active;

    @ManyToOne
    @JoinColumn(name = "CategoryId")
    private Category category;

    public Video() {}

    public String getVideoId() { return videoId; }
    public void setVideoId(String videoId) { this.videoId = videoId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getPoster() { return poster; }
    public void setPoster(String poster) { this.poster = poster; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getViews() { return views; }
    public void setViews(int views) { this.views = views; }

    public int getActive() { return active; }
    public void setActive(int active) { this.active = active; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
}