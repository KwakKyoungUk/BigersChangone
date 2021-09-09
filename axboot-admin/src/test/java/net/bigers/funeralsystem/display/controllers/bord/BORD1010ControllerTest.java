package net.bigers.funeralsystem.display.controllers.bord;

import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.axisj.axboot.admin.AdminApplicationInitializer;

import net.bigers.funeralsystem.crem0000.domain.hwaBrazier.HwaBrazierService;

@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(classes={AdminApplication.class, FuneralSystemConfiguration.class, CoreConfiguration.class})
@ContextConfiguration(classes={AdminApplicationInitializer.class})
@WebAppConfiguration
public class BORD1010ControllerTest {

	@Mock
	private HwaBrazierService hwaBrazierService;

	@InjectMocks
	//private BORD1010Controller bord1010Controller;

	@Autowired
	private WebApplicationContext wac;

	private MockMvc mockMvc;

	@Before
	public void setUp(){
		MockitoAnnotations.initMocks(this);
		//mockMvc = MockMvcBuilders.standaloneSetup(bord1010Controller).build();
	}

	@Test
	public void testBord1010Controller(){
		when(hwaBrazierService.count()).thenReturn(1L);

//		mockMvc.perform(get("/category/list")).andExpect(status().isOk());

		verify(hwaBrazierService).count();
		verifyNoMoreInteractions(hwaBrazierService);
	}

}
