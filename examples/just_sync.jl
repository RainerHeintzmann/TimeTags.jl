using TimeTags, Plots, Statistics

channels, time_tags = read_ptu(raw"firstexp2s.ptu");
overflows = time_tags[channels .== 255]
time_tags = time_tags[channels .!= 255]

N_max = 2000
rel_time = (time_tags[2:N_max].-time_tags[1:N_max-1]) 

plot(rel_time .* get_time_conversion(), ylabel="Time Difference / s", xlabel="Event")


rel_time = (time_tags[2:end].-time_tags[1:end-1]) 
histogram(rel_time.* get_time_conversion(), ylabel="Events", xlabel="Time Difference / s")

std(rel_time.* get_time_conversion())

###

channels, time_tags, dtimes = read_ptu(raw"C:\NoBackup\Data\FLIM\FRET_GFP_and_mRFP\DaisyPollen_cells_FLIM.ptu");
channels, time_tags, dtimes = read_ptu(raw"C:\NoBackup\Data\FLIM\FRET_GFP_and_mRFP\CENP-labelled_cells_for_FRET.ptu");
channels, time_tags, dtimes = read_ptu(raw"C:\NoBackup\Data\FLIM\FRET_GFP_and_mRFP\FRET_GFP_and_mRFP.ptu");
overflows = time_tags[channels .== 255]
time_tags = time_tags[channels .!= 255]

N_max = 2000
rel_time = (time_tags[2:N_max].-time_tags[1:N_max-1]) 

plot(time_tags[1:10:600000])

###

using View5D
q = read_flim(raw"C:\NoBackup\Data\FLIM\FRET_GFP_and_mRFP\DaisyPollen_cells_FLIM.ptu", sx = 350, marker_channel_y=21, tag_offset = 48.234); 
# 200x200
q = q[:,:,:,80:end,:]
@vv cat(sum(q, dims=4), get_t_mean(q),dims=4)

q = read_flim(raw"C:\NoBackup\Data\FLIM\FRET_GFP_and_mRFP\FRET_GFP_and_mRFP.ptu",  sx = 350, marker_channel_y=21, tag_offset = 48.234);
# 256x256
@vv sum(q, dims=(3,4))

q = read_flim(raw"C:\NoBackup\Data\FLIM\FRET_GFP_and_mRFP\CENP-labelled_cells_for_FRET.ptu",  sx = 350, data_channel=3, marker_channel_y=21);
# 512x512
@vv sum(q, dims=(3,4))

